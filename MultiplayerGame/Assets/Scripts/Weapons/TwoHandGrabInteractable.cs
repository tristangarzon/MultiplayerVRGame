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

public class TwoHandGrabInteractable : XRGrabInteractable
{
    #region Variables
    //Stores Grab Poitns of the object
    public List<XRSimpleInteractable> secondHandGrabPoints = new List<XRSimpleInteractable>();
    private XRBaseInteractor secondInteractor;
    private Quaternion attachInitialRotation;
    public enum TwoHandRotationType { None, First, Second};
    public TwoHandRotationType twoHandRotationType;
    public bool snapToSecondHand = true;
    private Quaternion initialRotationOffset;
    #endregion

    #region Unity Methods

    [System.Obsolete]
    void Start()
    {
        foreach (var item in secondHandGrabPoints)
        {
            item.onSelectEnter.AddListener(OnSecondHandGrab);
            item.onSelectEnter.AddListener(OnSecondHandRelease);
        }
    }

   
    void Update()
    {
        
    }

    public override void ProcessInteractable(XRInteractionUpdateOrder.UpdatePhase updatePhase)
    {
        //Changes the rotation of the object based off the rotation of the second hand
        if(secondInteractor && selectingInteractor)
        {
            //Compute the rotation
            if(snapToSecondHand)
            selectingInteractor.attachTransform.rotation = GetTwoHandRotation();
            else
                selectingInteractor.attachTransform.rotation = GetTwoHandRotation() * initialRotationOffset;
        }
        base.ProcessInteractable(updatePhase);
    }

    private Quaternion GetTwoHandRotation()  //Can set the rotation of the weapon to be the first or second hand
    {
        Quaternion targetRotation;
        if(twoHandRotationType == TwoHandRotationType.None)
        {
            targetRotation = Quaternion.LookRotation(secondInteractor.attachTransform.position - selectingInteractor.attachTransform.position);
        }
        else if(twoHandRotationType == TwoHandRotationType.First)
        {
            targetRotation = Quaternion.LookRotation(secondInteractor.attachTransform.position - selectingInteractor.attachTransform.position, selectingInteractor.transform.up);
        }
        else
        {
            targetRotation = Quaternion.LookRotation(secondInteractor.attachTransform.position - selectingInteractor.attachTransform.position, secondInteractor.attachTransform.up);
        }

        return targetRotation;
    }

    public void OnSecondHandGrab(XRBaseInteractor interactor) //Called when the second hand grabs an object
    {
        Debug.Log("SECOND HAND GRAB");
        secondInteractor = interactor;
        initialRotationOffset = Quaternion.Inverse(GetTwoHandRotation()) * selectingInteractor.attachTransform.rotation;
    }

    public void OnSecondHandRelease(XRBaseInteractor interactor)//Called when the second hand releases an object
    {
        Debug.Log("SECOND HAND RELEASE");
        secondInteractor = null;
    }

    protected override void OnSelectEntered(XRBaseInteractor interactor)
    {
        Debug.Log("FIRST GRAB ENTER");
        base.OnSelectEntered(interactor);
        attachInitialRotation = interactor.attachTransform.localRotation;
    }

    protected override void OnSelectExited(XRBaseInteractor interactor)
    {
        Debug.Log("FIRST GRAB EXIT");
        base.OnSelectExited(interactor);
        secondInteractor = null;
        interactor.attachTransform.localRotation = attachInitialRotation;
    }

    public override bool IsSelectableBy(XRBaseInteractor interactor)
    {
        //Checks if the object is already grabbed
        bool isAlreadyGrabbed = selectingInteractor && !interactor.Equals(selectingInteractor);
        return base.IsSelectableBy(interactor) && !isAlreadyGrabbed;
    }

    #endregion
}
