import cds from '@sap/cds';
import { SpaceFarer, IntergalacticPosition } from '#cds-models/IntergalacticService';

interface ValidationError {
    code: string;
    args?: any[];
}

const LOG = cds.log('IntergalacticService');
const STARTUP_BONUS = 10;

export default class IntergalacticService extends cds.ApplicationService {
    async init() {
        this.before('CREATE', SpaceFarer, (req) => this.onBeforeSpaceFarerCreate(req));
        this.before('UPDATE', SpaceFarer, (req) => this.onBeforeSpaceFarerUpdate(req));
        this.after('CREATE', SpaceFarer, (result, req) => this.onAfterSpaceFarerCreate(result, req));

        return super.init();
    }

    private async onBeforeSpaceFarerCreate(req: cds.Request<SpaceFarer>) {
        const error = await this.validateQualifications(req.data);
        if (error) {
            return req.error(400, error.code, error.args);
        }

        // enhancement: grant a startup bonus
        req.data.collectedStardust = (req.data.collectedStardust || 0) + STARTUP_BONUS;
    }

    private async onAfterSpaceFarerCreate(newSpaceFarer: SpaceFarer | undefined, req: cds.Request<SpaceFarer>) {
        if (newSpaceFarer) {
            LOG.info(`[Email Service] Sending cosmic notification email to ${newSpaceFarer.email}: "Congratulations on starting your adventurous journey among the stars!"`);
            req.notify('Notification_Success_SpaceFarerCreated', undefined, [newSpaceFarer.name]);
        } else {
            LOG.warn('System Warning: SpaceFarer creation successful, but no result data available for notification.');
        }
    }

    private async onBeforeSpaceFarerUpdate(req: cds.Request<SpaceFarer>) {
        const { ID: spaceFarer_ID, position_ID, collectedStardust, wormholeNavigationSkill } = req.data;

        if (!spaceFarer_ID) {
            LOG.warn('System Warning: SpaceFarer ID is missing for update operation.');
            return;
        }

        const hasRelevantChanges = Boolean(position_ID || collectedStardust !== undefined || wormholeNavigationSkill !== undefined);

        if (hasRelevantChanges) {
            const existing = await SELECT.one.from(SpaceFarer, spaceFarer_ID).columns('position_ID', 'collectedStardust', 'wormholeNavigationSkill');
            if (!existing) {
                return req.error(404, 'Validation_SpaceFarerNotFound', [spaceFarer_ID]);
            }

            const mergedData = { ...existing, ...req.data };

            const error = await this.validateQualifications(mergedData);
            if (error) {
                return req.error(400, error.code, error.args);
            }
        }
    }

    private async validateQualifications(spaceFarerData: SpaceFarer): Promise<ValidationError | undefined> {
        const { position_ID, collectedStardust, wormholeNavigationSkill } = spaceFarerData;

        if (!position_ID) {
            return { code: 'Validation_PositionRequired' };
        }

        const position = await SELECT.one.from(IntergalacticPosition).where({ ID: position_ID });
        if (!position) {
            return { code: 'Validation_PositionNotFound', args: [position_ID] };
        }

        if (typeof position.minStardust === 'number' && (collectedStardust || 0) < position.minStardust) {
            return { code: 'Validation_MinStardust', args: [position.minStardust, collectedStardust || 0] };
        }

        if (typeof position.minWormholeNavigationSkill === 'number' && (wormholeNavigationSkill || 0) < position.minWormholeNavigationSkill) {
            return { code: 'Validation_MinSkill', args: [position.minWormholeNavigationSkill, wormholeNavigationSkill || 0] };
        }
    }
}
