import {registry} from '@jahia/ui-extender';
import OpeningHoursJson from './OpeningHoursJson';

export default function () {
    registry.add('callback', 'OpeningHoursJsonEditor', {
        targets: ['jahiaApp-init:20'],
        callback: () => {
            registry.add('selectorType', 'OpeningHoursJson', {cmp: OpeningHoursJson, supportMultiple: false});
            console.debug('%c OpeningHoursJson Editor Extensions  is activated', 'color: #3c8cba');
        }
    });
}
