using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class VRMap
{

    public Transform vrTarget;
    public Transform rigTarget;
    public Vector3 trackingPositionOffset;
    public Vector3 trackingRotationOffset;
    public void Map()
    {
        rigTarget.position = vrTarget.TransformPoint(trackingPositionOffset);
        rigTarget.rotation = vrTarget.rotation * Quaternion.Euler(trackingRotationOffset);
    }
}

public class VRRig : MonoBehaviour
{
    public Transform root;
    [Range(0,1)]
    public float turnSmoothness = 1;
    public VRMap head;
    public VRMap leftHand;
    public VRMap rightHand;

    private Vector3 headBodyOffest;

    // Start is called before the first frame update
    void Start()
    {
        if (!root)
            root = transform;

        headBodyOffest = root.position - head.rigTarget.position;
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        root.position = head.rigTarget.position + headBodyOffest;
        root.forward = Vector3.Lerp(root.forward,
        Vector3.ProjectOnPlane(head.vrTarget.forward,Vector3.up).normalized, turnSmoothness);

        head.Map();
        leftHand.Map();
        rightHand.Map();
    }
}
