/*
* Made by: Tristan Garzon
* 
* Script Summary:
*
*/

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.Interaction.Toolkit;

public class LocomotionController : MonoBehaviour
{
    //Reference to the leftTeleportRay
    //Disabled for now, will add a feature to allow the player to select which hand they want to usedwn
    public XRController leftTeleportRay;

    //Reference to the rightTeleportRay
    public XRController rightTeleportRay;

    public InputHelpers.Button teleportActivationButton;
    public float activationThreshold = 0.1f;

    #region Variables

    #endregion
	
    #region Unity Methods

   
    void Update()
    {
        //Checks if Left ray is active
        if(leftTeleportRay)
        {
            leftTeleportRay.gameObject.SetActive(CheckIfActivated(leftTeleportRay));
        }

        if (rightTeleportRay)
        {
            rightTeleportRay.gameObject.SetActive(CheckIfActivated(rightTeleportRay));
        }
    }

    public bool CheckIfActivated(XRController controller)  //Checks to see if the ray is currently active
    {
        InputHelpers.IsPressed(controller.inputDevice, teleportActivationButton, out bool isActivated, activationThreshold);
        return isActivated;
           
    }

    #endregion
}
