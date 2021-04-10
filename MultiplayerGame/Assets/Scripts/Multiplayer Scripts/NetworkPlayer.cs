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
using Photon.Pun;
using UnityEngine.XR.Interaction.Toolkit;

public class NetworkPlayer : MonoBehaviour
{
    #region Variables
    public List<GameObject> avatars; //Stores a list of custom player models

    public Transform head;          //Reference to the player Head
    public Transform leftHand;      //Reference to the player Left Hand
    public Transform rightHand;     //Reference to the player Right Hand

    public Animator leftHandAnimator;
    public Animator rightHandAnimator;


    private Transform headRig;
    private Transform leftHandRig;
    private Transform rightHandRig;

    private PhotonView photonView;

    private GameObject spawnedAvatar;
    #endregion

    #region Unity Methods

    void Start()
    {
        photonView = GetComponent<PhotonView>();

        //Locates the XRRig in the scene
        XRRig rig = FindObjectOfType<XRRig>();
        //Stores the transform of the Camera 
        headRig = rig.transform.Find("Camera Offset/Main Camera");
        //Store the transform of the Left Hand 
        leftHandRig = rig.transform.Find("Camera Offset/LeftHand Controller");
        //Store the transform of the Left Hand 
        rightHandRig = rig.transform.Find("Camera Offset/RightHand Controller");

        //Loads Avatar
        if (photonView.IsMine)
            //Syncs the LoadAvatar function with other players over the network, even called when new players join the network 
            photonView.RPC("LoadAvatar", RpcTarget.AllBuffered, PlayerPrefs.GetInt("AvatarID"));

        
        
        
    }

    [PunRPC]
    public void LoadAvatar(int index)   //Loads an avatar among the avatar list
    {
        //Makes it so when this function is called on when avatar can exist for the player
        if (spawnedAvatar)
            Destroy(spawnedAvatar);


        //Instantiates the avatar list
        spawnedAvatar = Instantiate(avatars[index], transform); 
        //Gets the infomation about the spawned avatar
        AvatarInfo avatarInfo = spawnedAvatar.GetComponent<AvatarInfo>();

        //Sets the loaded avatars head to follow the XR rig head
        avatarInfo.head.SetParent(head, false);
        //Sets the loaded avatars leftHand to follow the XR rig left hand 
        avatarInfo.leftHand.SetParent(leftHand, false);
        //Sets the loaded avatars rightHand to follow the XR rig right hand
        avatarInfo.rightHand.SetParent(rightHand, false);

        leftHandAnimator = avatarInfo.leftHandAnimator;
        rightHandAnimator = avatarInfo.rightHandAnimator;
    }

    void Update()
    {
        //Checks to see which prefab component is being used 
        //If it's the users prefab then Update the following
        if(photonView.IsMine)
        {

            //Updates the Position/Rotation of the Head
            MapPosition(head, headRig);
            //Updates the Position/Rotation of the Left Hand
            MapPosition(leftHand, leftHandRig);
            //Updates the Position/Rotation of the Right Hand
            MapPosition(rightHand, rightHandRig);


            //Updates the animation of the Left Hand
            UpdateHandAnimation(InputDevices.GetDeviceAtXRNode(XRNode.LeftHand), leftHandAnimator);
            //Updates the animation of the Right Hand
            UpdateHandAnimation(InputDevices.GetDeviceAtXRNode(XRNode.RightHand), rightHandAnimator);

        }


    }

    void UpdateHandAnimation(InputDevice targetDevice, Animator handAnimator)  //Updates the hand animation
    {
        if (!handAnimator)
            return;

        if (targetDevice.TryGetFeatureValue(CommonUsages.trigger, out float triggerValue))
        {
            handAnimator.SetFloat("Trigger", triggerValue);
        }
        else
        {
            handAnimator.SetFloat("Trigger", 0);
        }

        if (targetDevice.TryGetFeatureValue(CommonUsages.grip, out float gripValue))
        {
            handAnimator.SetFloat("Grip", gripValue);
        }
        else
        {
            handAnimator.SetFloat("Grip", 0);
        }
    }

    void MapPosition(Transform target, Transform rigTransform) //Syncs the position of the XR device with the ingame player
    {
       

        //Sets the position to the target
        target.position = rigTransform.position;
        //Sets the rotation to the target
        target.rotation = rigTransform.rotation;
    }

    #endregion
}
