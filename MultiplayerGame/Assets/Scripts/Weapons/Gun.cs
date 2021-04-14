/*
* Made by: Tristan Garzon
* 
* Script Summary:
*
*/

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Gun : MonoBehaviour
{
    #region Variables
    public float speed = 40;    //Speed of Bullet
    public GameObject bullet;   //Reference to Bullet
    public Transform barrel;    //Reference to Barrel
    public AudioSource audioSource; //Bullet firing SFX
    public AudioClip audioClip;
    #endregion
	
    #region Unity Methods

    public void Fire()
    {
        GameObject spawnedBullet = Instantiate(bullet, barrel.position, barrel.rotation);
        spawnedBullet.GetComponent<Rigidbody>().velocity = speed * barrel.forward;
        audioSource.PlayOneShot(audioClip);
        Destroy(spawnedBullet, 2);
    }

    #endregion
}
