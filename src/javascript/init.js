import {registry} from '@jahia/ui-extender';
import OpeningHoursJson from './OpeningHoursJson';

export default function () {
    registry.add('callback', 'OpeningHoursJsonEditor', {
        targets: ['jahiaApp-init:20'],
        showOnNodeTypes: ['slocnt:store'],
        callback: () => {
            registry.add('selectorType', 'OpeningHoursJson', {cmp: OpeningHoursJson, supportMultiple: false});
            console.debug('%c OpeningHoursJson Editor Extensions  is activated', 'color: #3c8cba');
        }
    });
}
