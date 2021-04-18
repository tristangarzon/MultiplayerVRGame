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

public class ClimbInteractable : XRBaseInteractable
{
    #region Variables

    #endregion

    #region Unity Methods

    protected override void OnSelectEntered(XRBaseInteractor interactor)
    {
        base.OnSelectEntered(interactor);

        //Makes sure it isnt the xr ray that is interacting with the stones
        if(interactor is XRDirectInteractor)
        Climber.climbingHand = interactor.GetComponent<XRController>(); //Gets a reference of to the controller 
    }

    protected override void OnSelectExited(XRBaseInteractor interactor)
    {
        base.OnSelectExited(interactor);


        if(interactor is XRDirectInteractor)
        {
            if(Climber.climbingHand && Climber.climbingHand.name == interactor.name)
            {
                Climber.climbingHand = null;
            }
        }
    }

    #endregion
}
