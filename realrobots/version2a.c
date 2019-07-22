#pragma config(Sensor, S1, lightSensor, sensorEV3_Color, modeEV3Color_Ambient)

task main()
{
	while(true)
	{
		displayBigTextLine(1, "Light: %d", getColorAmbient(lightSensor));

		float photo;

		{
			float centerAmbient = getColorAmbient(lightSensor);
			photo = (centerAmbient - 0)*30;
		}

		motor[motorA] = 100000;
		motor[motorD] = photo+5+(getColorAmbient(lightSensor)*2);

		//if(getColorAmbient(lightSensorR)
		//motor[motorD] = photoRight-50+(getColorAmbient(lightSensorR)*3);
	}
}
