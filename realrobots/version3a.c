#pragma config(Sensor, S1,     lightSensorL,   sensorEV3_Color, modeEV3Color_Ambient)
#pragma config(Sensor, S2,     ultraSensorL,   sensorEV3_Ultrasonic)
#pragma config(Sensor, S3,     ultraSensorR,   sensorEV3_Ultrasonic)
#pragma config(Sensor, S4,     lightSensorR,   sensorEV3_Color, modeEV3Color_Ambient)

task main()
{
	while(true)
	{
		displayBigTextLine(1, "Left S: %d", getColorAmbient(lightSensorL));
		displayBigTextLine(3, "Left UL: %d", getUSDistance(ultraSensorL));
		displayBigTextLine(5, "Right S: %d", getColorAmbient(lightSensorR));
		displayBigTextLine(7, "Right UL: %d", getUSDistance(ultraSensorR));

		float photoLeft;
		float photoRight;
		float distLeft;
		float distRight;

		{
			float leftAmbient = getColorAmbient(lightSensorL);
			float rightAmbient = getColorAmbient(lightSensorR);
			photoLeft = (rightAmbient - 0)*30;
			photoRight = (leftAmbient - 0)*30;

			if(photoLeft > 100) {
				photoLeft = 100
			}

			if(photoRight > 100) {
				photoRight = 100
			}


			if(getUSDistance(ultraSensorL) < 70 && getColorAmbient(lightSensorL) < 20 && getColorAmbient(lightSensorR) < 20) {
				photoLeft = photoLeft-90;
				photoRight = photoRight+100;

			} else if(getUSDistance(ultraSensorR) < 70 && getColorAmbient(lightSensorL) < 20 && getColorAmbient(lightSensorR) < 20) {
				photoRight = photoRight-90;
				photoLeft = photoLeft+100;
			}
		}
		if((getColorAmbient(lightSensorL) > getColorAmbient(lightSensorR) || (getColorAmbient(lightSensorL) < 2 && getColorAmbient(lightSensorR)) < 2) && getUSDistance(ultraSensorL) >= 70 && getUSDistance(ultraSensorR) >= 70) {
			motor[motorA] = photoLeft+50+(getColorAmbient(lightSensorL)*3);
			motor[motorD] = photoRight-50+(getColorAmbient(lightSensorR)*3);
		}
		else {
			motor[motorD] = photoRight+50+(getColorAmbient(lightSensorR)*3);
			motor[motorA] = photoLeft-50+(getColorAmbient(lightSensorL)*3);
		}
	}
}
