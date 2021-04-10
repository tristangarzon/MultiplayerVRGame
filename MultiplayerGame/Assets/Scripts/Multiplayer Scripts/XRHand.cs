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
using UnityEngine.XR;

public class XRHand : MonoBehaviour
{
    #region Variables
    public string ANIM_LAYER_NAME_POINT = "Point Layer";
    public string ANIM_LAYER_NAME_THUMB = "Thumb Layer";
    public string ANIM_PARAM_NAME_FLEX = "Flex";
    public string ANIM_PARAM_NAME_PINCH = "Pinch";

    public const float INPUT_RATE_CHANGE = 20.0f;

    XRController xrController;
    [SerializeField]
    private Animator m_animator = null;

    private int m_animLayerIndexThumb = -1;
    private int m_animLayerIndexPoint = -1;
    private int m_animParamIndexFlex = -1;

    private bool m_isPointing = false;
    private bool m_isGivingThumbsUp = false;
    private float m_pointBlend = 0.0f;
    private float m_thumbsUpBlend = 0.0f;
    #endregion

    #region Unity Methods

    private void Start()
    {
        xrController = GetComponent<XRController>();
        // Get animator layer indices by name, for later use switching between hand visuals
        m_animLayerIndexPoint = m_animator.GetLayerIndex(ANIM_LAYER_NAME_POINT);
        m_animLayerIndexThumb = m_animator.GetLayerIndex(ANIM_LAYER_NAME_THUMB);
        m_animParamIndexFlex = Animator.StringToHash(ANIM_PARAM_NAME_FLEX);
    }

    private void Update()
    {
        //UpdateCapTouchStates();

        m_pointBlend = InputValueRateChange(m_isPointing, m_pointBlend);
        m_thumbsUpBlend = InputValueRateChange(m_isGivingThumbsUp, m_thumbsUpBlend);


        UpdateAnimStates();
    }

    // Just checking the state of the index and thumb cap touch sensors, but with a little bit of
    // debouncing.
    /*
    private void UpdateCapTouchStates()
    {
        xrController.inputDevice.TryGetFeatureValue(XRStatics.GetFeature(XRButton.Trigger),
            out var isntPointing);
        m_isPointing = !isntPointing;

        xrController.inputDevice.TryGetFeatureValue(XRStatics.GetFeature(XRButton.Primary2DAxisTouch),
            out var isPressed);
        m_isGivingThumbsUp = !isPressed;
    }
    */

    private float InputValueRateChange(bool isDown, float value)
    {
        float rateDelta = Time.deltaTime * INPUT_RATE_CHANGE;
        float sign = isDown ? 1.0f : -1.0f;
        return Mathf.Clamp01(value + rateDelta * sign);
    }

    private void UpdateAnimStates()
    {
        // Flex
        // blend between open hand and fully closed fist
        xrController.inputDevice.TryGetFeatureValue(CommonUsages.grip, out float flex);
        m_animator.SetFloat(m_animParamIndexFlex, flex);

        // Point
        xrController.inputDevice.TryGetFeatureValue(CommonUsages.trigger, out float pinch);
        float point = (1 - pinch) * 0.5f;
        m_animator.SetLayerWeight(m_animLayerIndexPoint, point);

        // Thumbs up
        float thumbsUp = m_thumbsUpBlend;
        m_animator.SetLayerWeight(m_animLayerIndexThumb, thumbsUp);


        m_animator.SetFloat(ANIM_PARAM_NAME_PINCH, pinch);
    }

    #endregion
}
