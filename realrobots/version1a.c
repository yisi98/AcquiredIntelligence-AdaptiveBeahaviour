#pragma config(Sensor, S1, lightSensorL, sensorEV3_Color, modeEV3Color_Ambient)
#pragma config(Sensor, S4, lightSensorR, sensorEV3_Color, modeEV3Color_Ambient)

task main()
{
	while(true)
	{
		displayBigTextLine(1, "Left: %d", getColorAmbient(lightSensorL));
		displayBigTextLine(3, "Right: %d", getColorAmbient(lightSensorR));

		float photoLeft;
		float photoRight;
		float distLeft;
		float distRight;

		{
			float leftAmbient = getColorAmbient(lightSensorL);
			float rightAmbient = getColorAmbient(lightSensorR);
			photoLeft = (rightAmbient - 0)*30;
			photoRight = (leftAmbient - 0)*30;
		}

		if(getColorAmbient(lightSensorL) > getColorAmbient(lightSensorR) || (getColorAmbient(lightSensorL) < 2 && getColorAmbient(lightSensorR)) < 2) {
			motor[motorA] = photoLeft+50+(getColorAmbient(lightSensorL)*3);
			motor[motorD] = photoRight-50+(getColorAmbient(lightSensorR)*3);
		}
		else {
			motor[motorD] = photoRight+50+(getColorAmbient(lightSensorR)*3);
			motor[motorA] = photoLeft-50+(getColorAmbient(lightSensorL)*3);
		}


	}
}
