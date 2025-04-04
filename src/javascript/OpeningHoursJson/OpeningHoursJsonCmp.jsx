import React from 'react';
import * as PropTypes from 'prop-types';
import {useTranslation} from 'react-i18next';
import {Grid, MenuItem, withStyles} from '@material-ui/core';
import {Select} from '@jahia/design-system-kit';

const styles = () => ({
    container: {
        padding: '.5rem',
        boxShadow: '0px 2px 10px -5px #000000, 2px 5px 15px 5px rgba(0,0,0,0);'
    }
});

const selectProps = {
    fullWidth: true,
    style: {
        width: '95%',
        backgroundColor: 'white',
        background: 'white !important'
    }
};

const DAYS = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
];

const TIMES = Array.from({length: 48}, (_, i) => {
    const hours = String(Math.floor(i / 2)).padStart(2, '0');
    const minutes = i % 2 === 0 ? '00' : '30';
    return `${hours}:${minutes}`;
});

const formatOpeningHourValue = value => {
    const defaultValue = {
        dayOfWeek: 'Monday',
        opens: '09:00',
        closes: '18:00'
    };

    if (!value) {
        return defaultValue;
    }

    try {
        return typeof value === 'string' ? JSON.parse(value) : value;
    } catch (_) {
        return defaultValue;
    }
};

const OpeningHoursJsonCmp = ({field, id, value, onChange, classes}) => {
    const {t} = useTranslation('store-locator');
    const controlledValue = formatOpeningHourValue(value);

    const handleChange = key => event => {
        controlledValue[key] = event.target.value;
        onChange(JSON.stringify(controlledValue));
    };

    return (
        <Grid container spacing={3} className={classes.container}>
            <Grid item xs={12} sm={4}>
                <Select
                    {...selectProps}
                    id={`dayOfWeek-${id}`}
                    label={t('label.dayOfWeek')}
                    value={controlledValue.dayOfWeek}
                    disabled={field.readOnly}
                    onChange={handleChange('dayOfWeek')}
                >
                    {DAYS.map(day => (
                        <MenuItem key={day} value={day}>{t(`days.${day}`)}</MenuItem>
                    ))}
                </Select>
            </Grid>
            <Grid item xs={6} sm={4}>
                <Select
                    {...selectProps}
                    id={`opens-${id}`}
                    label={t('label.opens')}
                    value={controlledValue.opens}
                    disabled={field.readOnly}
                    onChange={handleChange('opens')}
                >
                    {TIMES.map(time => (
                        <MenuItem key={time} value={time}>{time}</MenuItem>
                    ))}
                </Select>
            </Grid>
            <Grid item xs={6} sm={4}>
                <Select
                    {...selectProps}
                    id={`closes-${id}`}
                    label={t('label.closes')}
                    value={controlledValue.closes}
                    disabled={field.readOnly}
                    onChange={handleChange('closes')}
                >
                    {TIMES.map(time => (
                        <MenuItem key={time} value={time}>{time}</MenuItem>
                    ))}
                </Select>
            </Grid>
        </Grid>
    );
};

OpeningHoursJsonCmp.propTypes = {
    field: PropTypes.object,
    id: PropTypes.string.isRequired,
    value: PropTypes.string,
    onChange: PropTypes.func.isRequired,
    classes: PropTypes.object.isRequired
};

export const OpeningHoursJson = withStyles(styles)(OpeningHoursJsonCmp);
OpeningHoursJsonCmp.displayName = 'OpeningHoursJsonCmp';
