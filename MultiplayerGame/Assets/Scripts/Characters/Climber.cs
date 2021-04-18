/*
* Made by: Tristan Garzon
* 
* Script Summary:
*
*/

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR;
using UnityEngine.XR.Interaction.Toolkit;

public class Climber : MonoBehaviour
{
    #region Variables
    private CharacterController character;  //Reference to character
    public static XRController climbingHand;       //Reference to the hands
    private DeviceBasedContinuousMoveProvider contMovement;
    #endregion
	
    #region Unity Methods

    void Start()
    {
        character = GetComponent<CharacterController>();
        contMovement = GetComponent<DeviceBasedContinuousMoveProvider>();
    }

    void FixedUpdate()
    {
        //Will disable the movement of the character if the character is climbing
        if(climbingHand)
        {
            contMovement.enabled = false;
            Climb();
        }
        else
        {
            contMovement.enabled = true;
        }
    }

    void Climb() //Allows the player to climb
    {
        //Finds the velocity of the climbing hand
        InputDevices.GetDeviceAtXRNode(climbingHand.controllerNode).TryGetFeatureValue(CommonUsages.deviceVelocity, out Vector3 velocity);

        //Moves our body in the opposite direction
        character.Move(transform.rotation * -velocity * Time.fixedDeltaTime);
    }

    #endregion
}
