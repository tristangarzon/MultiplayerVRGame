/*
* Made by: Tristan Garzon
* 
* Script Summary:
* Moves the playuer continuously using the joystick
*/

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR;
using UnityEngine.XR.Interaction.Toolkit;

public class ContinuousMovement : MonoBehaviour
{
    #region Variables
    public XRNode inputSource;  //Reference to an Input Source from the controller
    public float speed = 1f;    //Player Speed
    public float gravity = -9.81f; //Earth's gravity
    public LayerMask groundLayer;
    public float additionalHeight = 0.2f;

    private float fallingSpeed; //How fast are player falls
    private Vector2 inputAxis;  //Reference to the joystick
    private CharacterController character;  //Reference to the player
    private XRRig rig;          //Reference to the XR rig



    #endregion
	
    #region Unity Methods

    void Start()
    {
        character = GetComponent<CharacterController>();
        rig = GetComponent<XRRig>();
    }

   
    void Update()
    {
        //Gets the input from the left controllers joystick (Left because the inputSource is set to that controller)
        InputDevice device = InputDevices.GetDeviceAtXRNode(inputSource);
        device.TryGetFeatureValue(CommonUsages.primary2DAxis, out inputAxis);
    }

    private void FixedUpdate()
    {
        CapsuleFollowHeadset();

        //Head Direction
        Quaternion headYaw = Quaternion.Euler(0, rig.cameraGameObject.transform.eulerAngles.y, 0);
        //Direction of XR rig
        Vector3 direction = headYaw * new Vector3(inputAxis.x, 0, inputAxis.y);

        //Moves the character
        character.Move(direction * Time.fixedDeltaTime * speed);

        //Gravity

        //Checks if player is grounded
        bool isGrounded = CheckIfGrounded();
        if (isGrounded)
            //Sets fallingSpeed to 0 if player is on the ground
            fallingSpeed = 0;
        else
            //Increases fall speed depending on distance towards the ground
            fallingSpeed += gravity * Time.fixedDeltaTime;

        //Moves the player down
        character.Move(Vector3.up * fallingSpeed * Time.fixedDeltaTime);
    }

    void CapsuleFollowHeadset() //<-- What name says
    {
        //Height of capsule is adjusted to the headset height
        character.height = rig.cameraInRigSpaceHeight + additionalHeight;
        Vector3 capsuleCenter = transform.InverseTransformPoint(rig.cameraGameObject.transform.position);
        character.center = new Vector3(capsuleCenter.x, character.height / 2 + character.skinWidth,  capsuleCenter.z);
    }

    bool CheckIfGrounded() //Checks if player is on the ground
    {
        //Shoots a ray from the center of the character to the floor
        Vector3 rayStart = transform.TransformPoint(character.center);
        float rayLength = character.center.y + 0.01f;

        //Checks to see if the ray has hit the ground
        bool hasHit = Physics.SphereCast(rayStart, character.radius, Vector3.down, out RaycastHit hitInfo, rayLength);
        return hasHit;
    }

    #endregion
}
