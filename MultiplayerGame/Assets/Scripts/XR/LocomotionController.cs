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

    //Reference to the Ray Interactors
    public XRRayInteractor leftInteractorRay;
    public XRRayInteractor rightInteractorRay;

    public bool EnableRightTeleport { get; set; } = true;
    public bool EnableLeftTeleport { get; set; } = true;

    #region Variables

    #endregion
	
    #region Unity Methods

   
    void Update()
    {
        Vector3 pos = new Vector3();
        Vector3 norm = new Vector3();
        int index = 0;
        bool validTarget = false;


        //Checks if Left ray is active
        if(leftTeleportRay)
        {
            bool isLeftInteractorRayHovering = leftInteractorRay.TryGetHitInfo(ref pos, ref norm, ref index, ref validTarget);
            leftTeleportRay.gameObject.SetActive(EnableLeftTeleport && CheckIfActivated(leftTeleportRay) && !isLeftInteractorRayHovering);
        }

        if (rightTeleportRay)
        {
            bool isRightInteractorRayHovering = rightInteractorRay.TryGetHitInfo(ref pos, ref norm, ref index, ref validTarget);
            rightTeleportRay.gameObject.SetActive(EnableRightTeleport && CheckIfActivated(rightTeleportRay) && !isRightInteractorRayHovering);
        }
    }

    public bool CheckIfActivated(XRController controller)  //Checks to see if the ray is currently active
    {
        InputHelpers.IsPressed(controller.inputDevice, teleportActivationButton, out bool isActivated, activationThreshold);
        return isActivated;
           
    }

    #endregion
}
