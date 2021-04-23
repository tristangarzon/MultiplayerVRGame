/*
* Made by: Tristan Garzon
* 
* Script Summary:
*
*/

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class OnTargetReached : MonoBehaviour
{
    #region Variables
    public float threshold = 0.02f;
    public Transform target;
    public UnityEvent OnReached;
    private bool wasReached = false;
    #endregion

    #region Unity Methods

    private void FixedUpdate()
    {
        //Checks tot see if the target (Gun slider) has reached the threshold point
        float distance = Vector3.Distance(transform.position, target.position);

        if (distance < threshold && !wasReached)
        {
            //Has reached the target
            OnReached.Invoke();
            wasReached = true;
        }
        else if(distance >= threshold)
        {
            wasReached = false;
        }
    }

    #endregion
}
