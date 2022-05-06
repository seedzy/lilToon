Shader "Hidden/lilToonMultiFur"
{
    // Memo
    // If you are using Unity 2018 or earlier, you need to replace `shader_feature_local` with` shader_feature`.
    // If there are too many variants, you should also replace them with #define.

    Properties
    {
        //----------------------------------------------------------------------------------------------------------------------
        // Base
        [lilToggle]     _Invisible                  ("Invisible", Int) = 0
                        _AsUnlit                    ("As Unlit", Range(0, 1)) = 0
                        _Cutoff                     ("Alpha Cutoff", Range(-0.001,1.001)) = 0.001
                        _SubpassCutoff              ("Subpass Alpha Cutoff", Range(0,1)) = 0.5
        [lilToggle]     _FlipNormal                 ("Flip Backface Normal", Int) = 0
        [lilToggle]     _ShiftBackfaceUV            ("Shift Backface UV", Int) = 0
                        _BackfaceForceShadow        ("Backface Force Shadow", Range(0,1)) = 0
                        _VertexLightStrength        ("Vertex Light Strength", Range(0,1)) = 0
                        _LightMinLimit              ("Light Min Limit", Range(0,1)) = 0.05
                        _LightMaxLimit              ("Light Max Limit", Range(0,10)) = 1
                        _BeforeExposureLimit        ("Before Exposure Limit", Float) = 10000
                        _MonochromeLighting         ("Monochrome lighting", Range(0,1)) = 0
                        _AlphaBoostFA               ("Alpha Boost", Range(1,100)) = 10
                        _lilDirectionalLightStrength ("Directional Light Strength", Range(0,1)) = 1
        [lilVec3B]      _LightDirectionOverride     ("Light Direction Override", Vector) = (0.001,0.002,0.001,0)

        //----------------------------------------------------------------------------------------------------------------------
        // Main
        [lilHDR]        _Color                      ("Color", Color) = (1,1,1,1)
        [MainTexture]   _MainTex                    ("Texture", 2D) = "white" {}
        [lilUVAnim]     _MainTex_ScrollRotate       ("Angle|UV Animation|Scroll|Rotate", Vector) = (0,0,0,0)
        [lilHSVG]       _MainTexHSVG                ("Hue|Saturation|Value|Gamma", Vector) = (0,1,1,1)
                        _MainGradationStrength      ("Gradation Strength", Range(0, 1)) = 0
        [NoScaleOffset] _MainGradationTex           ("Gradation Map", 2D) = "white" {}
        [NoScaleOffset] _MainColorAdjustMask        ("Adjust Mask", 2D) = "white" {}

        //----------------------------------------------------------------------------------------------------------------------
        // Main2nd
        [lilToggleLeft] _UseMain2ndTex              ("Use Main 2nd", Int) = 0
        [lilHDR]        _Color2nd                   ("Color", Color) = (1,1,1,1)
                        _Main2ndTex                 ("Texture", 2D) = "white" {}
        [lilEnum]       _Main2ndTex_UVMode          ("UV Mode|UV0|UV1|UV2|UV3|MatCap", Int) = 0
        [lilAngle]      _Main2ndTexAngle            ("Angle", Float) = 0
        [lilDecalAnim]  _Main2ndTexDecalAnimation   ("Animation|X Size|Y Size|Frames|FPS", Vector) = (1,1,1,30)
        [lilDecalSub]   _Main2ndTexDecalSubParam    ("Ratio X|Ratio Y|Fix Border", Vector) = (1,1,0,1)
        [lilToggle]     _Main2ndTexIsDecal          ("As Decal", Int) = 0
        [lilToggle]     _Main2ndTexIsLeftOnly       ("Left Only", Int) = 0
        [lilToggle]     _Main2ndTexIsRightOnly      ("Right Only", Int) = 0
        [lilToggle]     _Main2ndTexShouldCopy       ("Copy", Int) = 0
        [lilToggle]     _Main2ndTexShouldFlipMirror ("Flip Mirror", Int) = 0
        [lilToggle]     _Main2ndTexShouldFlipCopy   ("Flip Copy", Int) = 0
        [lilToggle]     _Main2ndTexIsMSDF           ("As MSDF", Int) = 0
        [NoScaleOffset] _Main2ndBlendMask           ("Mask", 2D) = "white" {}
        [lilEnum]       _Main2ndTexBlendMode        ("Blend Mode|Normal|Add|Screen|Multiply", Int) = 0
                        _Main2ndEnableLighting      ("Enable Lighting", Range(0, 1)) = 1
                        _Main2ndDissolveMask        ("Dissolve Mask", 2D) = "white" {}
                        _Main2ndDissolveNoiseMask   ("Dissolve Noise Mask", 2D) = "gray" {}
        [lilUVAnim]     _Main2ndDissolveNoiseMask_ScrollRotate ("Scroll", Vector) = (0,0,0,0)
                        _Main2ndDissolveNoiseStrength ("Dissolve Noise Strength", float) = 0.1
        [lilHDR]        _Main2ndDissolveColor       ("Dissolve Color", Color) = (1,1,1,1)
        [lilDissolve]   _Main2ndDissolveParams      ("Dissolve Mode|None|Alpha|UV|Position|Dissolve Shape|Point|Line|Border|Blur", Vector) = (0,0,0.5,0.1)
        [lilDissolveP]  _Main2ndDissolvePos         ("Dissolve Position", Vector) = (0,0,0,0)
        [lilFFFB]       _Main2ndDistanceFade        ("Start|End|Strength|Fix backface", Vector) = (0.1,0.01,0,0)

        //----------------------------------------------------------------------------------------------------------------------
        // Main3rd
        [lilToggleLeft] _UseMain3rdTex              ("Use Main 3rd", Int) = 0
        [lilHDR]        _Color3rd                   ("Color", Color) = (1,1,1,1)
                        _Main3rdTex                 ("Texture", 2D) = "white" {}
        [lilAngle]      _Main3rdTexAngle            ("Angle", Float) = 0
        [lilEnum]       _Main3rdTex_UVMode          ("UV Mode|UV0|UV1|UV2|UV3|MatCap", Int) = 0
        [lilDecalAnim]  _Main3rdTexDecalAnimation   ("Animation|X Size|Y Size|Frames|FPS", Vector) = (1,1,1,30)
        [lilDecalSub]   _Main3rdTexDecalSubParam    ("Ratio X|Ratio Y|Fix Border", Vector) = (1,1,0,1)
        [lilToggle]     _Main3rdTexIsDecal          ("As Decal", Int) = 0
        [lilToggle]     _Main3rdTexIsLeftOnly       ("Left Only", Int) = 0
        [lilToggle]     _Main3rdTexIsRightOnly      ("Right Only", Int) = 0
        [lilToggle]     _Main3rdTexShouldCopy       ("Copy", Int) = 0
        [lilToggle]     _Main3rdTexShouldFlipMirror ("Flip Mirror", Int) = 0
        [lilToggle]     _Main3rdTexShouldFlipCopy   ("Flip Copy", Int) = 0
        [lilToggle]     _Main3rdTexIsMSDF           ("As MSDF", Int) = 0
        [NoScaleOffset] _Main3rdBlendMask           ("Mask", 2D) = "white" {}
        [lilEnum]       _Main3rdTexBlendMode        ("Blend Mode|Normal|Add|Screen|Multiply", Int) = 0
                        _Main3rdEnableLighting      ("Enable Lighting", Range(0, 1)) = 1
                        _Main3rdDissolveMask        ("Dissolve Mask", 2D) = "white" {}
                        _Main3rdDissolveNoiseMask   ("Dissolve Noise Mask", 2D) = "gray" {}
        [lilUVAnim]     _Main3rdDissolveNoiseMask_ScrollRotate ("Scroll", Vector) = (0,0,0,0)
                        _Main3rdDissolveNoiseStrength ("Dissolve Noise Strength", float) = 0.1
        [lilHDR]        _Main3rdDissolveColor       ("Dissolve Color", Color) = (1,1,1,1)
        [lilDissolve]   _Main3rdDissolveParams      ("Dissolve Mode|None|Alpha|UV|Position|Dissolve Shape|Point|Line|Border|Blur", Vector) = (0,0,0.5,0.1)
        [lilDissolveP]  _Main3rdDissolvePos         ("Dissolve Position", Vector) = (0,0,0,0)
        [lilFFFB]       _Main3rdDistanceFade        ("Start|End|Strength|Fix backface", Vector) = (0.1,0.01,0,0)

        //----------------------------------------------------------------------------------------------------------------------
        // Alpha Mask
        [lilEnumLabel]  _AlphaMaskMode              ("AlphaMask|", Int) = 0
        [NoScaleOffset] _AlphaMask                  ("AlphaMask", 2D) = "white" {}
                        _AlphaMaskScale             ("Scale", Float) = 1
                        _AlphaMaskValue             ("Offset", Float) = 0

        //----------------------------------------------------------------------------------------------------------------------
        // NormalMap
        [lilToggleLeft] _UseBumpMap                 ("Use Normal Map", Int) = 0
        [Normal]        _BumpMap                    ("Normal Map", 2D) = "bump" {}
                        _BumpScale                  ("Scale", Range(-10,10)) = 1

        //----------------------------------------------------------------------------------------------------------------------
        // NormalMap 2nd
        [lilToggleLeft] _UseBump2ndMap              ("Use Normal Map 2nd", Int) = 0
        [Normal]        _Bump2ndMap                 ("Normal Map", 2D) = "bump" {}
                        _Bump2ndScale               ("Scale", Range(-10,10)) = 1
        [NoScaleOffset] _Bump2ndScaleMask           ("Mask", 2D) = "white" {}

        //----------------------------------------------------------------------------------------------------------------------
        // Anisotropy
        [lilToggleLeft] _UseAnisotropy              ("Use Anisotropy", Int) = 0
        [Normal]        _AnisotropyTangentMap       ("Tangent Map", 2D) = "bump" {}
                        _AnisotropyScale            ("Scale", Range(-1,1)) = 1
        [NoScaleOffset] _AnisotropyScaleMask        ("Scale Mask", 2D) = "white" {}
                        _AnisotropyTangentWidth     ("Tangent Width", Range(0,10)) = 1
                        _AnisotropyBitangentWidth   ("Bitangent Width", Range(0,10)) = 1
                        _AnisotropyShift            ("Shift", Range(-10,10)) = 0
                        _AnisotropyShiftNoiseScale  ("Shift Noise Scale", Range(-1,1)) = 0
                        _AnisotropySpecularStrength ("Specular Strength", Range(0,10)) = 1
                        _Anisotropy2ndTangentWidth  ("2nd Tangent Width", Range(0,10)) = 1
                        _Anisotropy2ndBitangentWidth ("2nd Bitangent Width", Range(0,10)) = 1
                        _Anisotropy2ndShift         ("2nd Shift", Range(-10,10)) = 0
                        _Anisotropy2ndShiftNoiseScale ("2nd Shift Noise Scale", Range(-1,1)) = 0
                        _Anisotropy2ndSpecularStrength ("2nd Specular Strength", Range(0,10)) = 0
                        _AnisotropyShiftNoiseMask   ("Shift Noise Mask", 2D) = "white" {}
        [lilToggle]     _Anisotropy2Reflection      ("Reflection", Int) = 0
        [lilToggle]     _Anisotropy2MatCap          ("MatCap", Int) = 0
        [lilToggle]     _Anisotropy2MatCap2nd       ("MatCap 2nd", Int) = 0

        //----------------------------------------------------------------------------------------------------------------------
        // Backlight
        [lilToggleLeft] _UseBacklight               ("Use Backlight", Int) = 0
        [lilHDR]        _BacklightColor             ("Color", Color) = (0.85,0.8,0.7,1.0)
        [NoScaleOffset] _BacklightColorTex          ("Texture", 2D) = "white" {}
                        _BacklightNormalStrength    ("Normal Strength", Range(0, 1)) = 1.0
                        _BacklightBorder            ("Border", Range(0, 1)) = 0.35
                        _BacklightBlur              ("Blur", Range(0, 1)) = 0.05
                        _BacklightDirectivity       ("Directivity", Float) = 5.0
                        _BacklightViewStrength      ("View direction strength", Range(0, 1)) = 1
        [lilToggle]     _BacklightReceiveShadow     ("Receive Shadow", Int) = 1
        [lilToggle]     _BacklightBackfaceMask      ("Backface Mask", Int) = 1

        //----------------------------------------------------------------------------------------------------------------------
        // Shadow
        [lilToggleLeft] _UseShadow                  ("Use Shadow", Int) = 0
                        _ShadowStrength             ("Strength", Range(0, 1)) = 1
        [NoScaleOffset] _ShadowStrengthMask         ("Strength", 2D) = "white" {}
        [NoScaleOffset] _ShadowBorderMask           ("Border", 2D) = "white" {}
        [NoScaleOffset] _ShadowBlurMask             ("Blur", 2D) = "white" {}
        [lilFFFF]       _ShadowAOShift              ("1st Scale|1st Offset|2nd Scale|2nd Offset", Vector) = (1,0,1,0)
        [lilFF]         _ShadowAOShift2             ("3rd Scale|3rd Offset", Vector) = (1,0,1,0)
        [lilToggle]     _ShadowPostAO               ("Post AO", Int) = 0
                        _ShadowColor                ("Shadow Color", Color) = (0.7,0.75,0.85,1.0)
        [NoScaleOffset] _ShadowColorTex             ("Shadow Color", 2D) = "black" {}
                        _ShadowNormalStrength       ("Normal Strength", Range(0, 1)) = 1.0
                        _ShadowBorder               ("Border", Range(0, 1)) = 0.5
                        _ShadowBlur                 ("Blur", Range(0, 1)) = 0.1
                        _ShadowReceive              ("Receive Shadow", Range(0, 1)) = 0
                        _Shadow2ndColor             ("2nd Color", Color) = (0,0,0,0)
        [NoScaleOffset] _Shadow2ndColorTex          ("2nd Color", 2D) = "black" {}
                        _Shadow2ndNormalStrength    ("2nd Normal Strength", Range(0, 1)) = 1.0
                        _Shadow2ndBorder            ("2nd Border", Range(0, 1)) = 0.5
                        _Shadow2ndBlur              ("2nd Blur", Range(0, 1)) = 0.3
                        _Shadow2ndReceive           ("Receive Shadow", Range(0, 1)) = 0
                        _Shadow3rdColor             ("3rd Color", Color) = (0,0,0,0)
        [NoScaleOffset] _Shadow3rdColorTex          ("3rd Color", 2D) = "black" {}
                        _Shadow3rdNormalStrength    ("3rd Normal Strength", Range(0, 1)) = 1.0
                        _Shadow3rdBorder            ("3rd Border", Range(0, 1)) = 0.25
                        _Shadow3rdBlur              ("3rd Blur", Range(0, 1)) = 0.1
                        _Shadow3rdReceive           ("Receive Shadow", Range(0, 1)) = 0
                        _ShadowBorderColor          ("Border Color", Color) = (1,0,0,1)
                        _ShadowBorderRange          ("Border Range", Range(0, 1)) = 0
                        _ShadowMainStrength         ("Contrast", Range(0, 1)) = 1
                        _ShadowEnvStrength          ("Environment Strength", Range(0, 1)) = 0
        [lilEnum]       _ShadowMaskType             ("Mask Type|Strength|Flat", Int) = 0
                        _ShadowFlatBorder           ("Border", Range(-2, 2)) = 1
                        _ShadowFlatBlur             ("Blur", Range(0.001, 2)) = 1

        //----------------------------------------------------------------------------------------------------------------------
        // Reflection
        [lilToggleLeft] _UseReflection              ("Use Reflection", Int) = 0
        // Smoothness
                        _Smoothness                 ("Smoothness", Range(0, 1)) = 1
        [NoScaleOffset] _SmoothnessTex              ("Smoothness", 2D) = "white" {}
        // Metallic
        [Gamma]         _Metallic                   ("Metallic", Range(0, 1)) = 0
        [NoScaleOffset] _MetallicGlossMap           ("Metallic", 2D) = "white" {}
        // Reflectance
        [Gamma]         _Reflectance                ("Reflectance", Range(0, 1)) = 0.04
        // Reflection
        [lilToggle]     _ApplySpecular              ("Apply Specular", Int) = 1
        [lilToggle]     _ApplySpecularFA            ("Apply Specular in ForwardAdd", Int) = 1
        [lilToggle]     _SpecularToon               ("Specular Toon", Int) = 1
                        _SpecularNormalStrength     ("Normal Strength", Range(0, 1)) = 1.0
                        _SpecularBorder             ("Border", Range(0, 1)) = 0.5
                        _SpecularBlur               ("Blur", Range(0, 1)) = 0.0
        [lilToggle]     _ApplyReflection            ("Apply Reflection", Int) = 0
                        _ReflectionNormalStrength   ("Normal Strength", Range(0, 1)) = 1.0
        [lilHDR]        _ReflectionColor            ("Color", Color) = (1,1,1,1)
        [NoScaleOffset] _ReflectionColorTex         ("Color", 2D) = "white" {}
        [lilToggle]     _ReflectionApplyTransparency ("Apply Transparency", Int) = 1
        [NoScaleOffset] _ReflectionCubeTex          ("Cubemap Fallback", Cube) = "black" {}
        [lilHDR]        _ReflectionCubeColor        ("Color", Color) = (0,0,0,1)
        [lilToggle]     _ReflectionCubeOverride     ("Override", Int) = 0
                        _ReflectionCubeEnableLighting ("Enable Lighting", Range(0, 1)) = 1

        //----------------------------------------------------------------------------------------------------------------------
        // MatCap
        [lilToggleLeft] _UseMatCap                  ("Use MatCap", Int) = 0
        [lilHDR]        _MatCapColor                ("Color", Color) = (1,1,1,1)
                        _MatCapTex                  ("Texture", 2D) = "white" {}
        [lilVec2R]      _MatCapBlendUV1             ("Blend UV1", Vector) = (0,0,0,0)
        [lilToggle]     _MatCapZRotCancel           ("Z-axis rotation cancellation", Int) = 1
        [lilToggle]     _MatCapPerspective          ("Fix Perspective", Int) = 1
                        _MatCapVRParallaxStrength   ("VR Parallax Strength", Range(0, 1)) = 1
                        _MatCapBlend                ("Blend", Range(0, 1)) = 1
        [NoScaleOffset] _MatCapBlendMask            ("Mask", 2D) = "white" {}
                        _MatCapEnableLighting       ("Enable Lighting", Range(0, 1)) = 1
                        _MatCapShadowMask           ("Shadow Mask", Range(0, 1)) = 0
        [lilToggle]     _MatCapBackfaceMask         ("Backface Mask", Int) = 0
                        _MatCapLod                  ("Blur", Range(0, 10)) = 0
        [lilEnum]       _MatCapBlendMode            ("Blend Mode|Normal|Add|Screen|Multiply", Int) = 1
        [lilToggle]     _MatCapApplyTransparency    ("Apply Transparency", Int) = 1
                        _MatCapNormalStrength       ("Normal Strength", Range(0, 1)) = 1.0
        [lilToggle]     _MatCapCustomNormal         ("MatCap Custom Normal Map", Int) = 0
        [Normal]        _MatCapBumpMap              ("Normal Map", 2D) = "bump" {}
                        _MatCapBumpScale            ("Scale", Range(-10,10)) = 1

        //----------------------------------------------------------------------------------------------------------------------
        // MatCap 2nd
        [lilToggleLeft] _UseMatCap2nd               ("Use MatCap 2nd", Int) = 0
        [lilHDR]        _MatCap2ndColor             ("Color", Color) = (1,1,1,1)
                        _MatCap2ndTex               ("Texture", 2D) = "white" {}
        [lilVec2R]      _MatCap2ndBlendUV1          ("Blend UV1", Vector) = (0,0,0,0)
        [lilToggle]     _MatCap2ndZRotCancel        ("Z-axis rotation cancellation", Int) = 1
        [lilToggle]     _MatCap2ndPerspective       ("Fix Perspective", Int) = 1
                        _MatCap2ndVRParallaxStrength ("VR Parallax Strength", Range(0, 1)) = 1
                        _MatCap2ndBlend             ("Blend", Range(0, 1)) = 1
        [NoScaleOffset] _MatCap2ndBlendMask         ("Mask", 2D) = "white" {}
                        _MatCap2ndEnableLighting    ("Enable Lighting", Range(0, 1)) = 1
                        _MatCap2ndShadowMask        ("Shadow Mask", Range(0, 1)) = 0
        [lilToggle]     _MatCap2ndBackfaceMask      ("Backface Mask", Int) = 0
                        _MatCap2ndLod               ("Blur", Range(0, 10)) = 0
        [lilEnum]       _MatCap2ndBlendMode         ("Blend Mode|Normal|Add|Screen|Multiply", Int) = 1
        [lilToggle]     _MatCap2ndApplyTransparency ("Apply Transparency", Int) = 1
                        _MatCap2ndNormalStrength    ("Normal Strength", Range(0, 1)) = 1.0
        [lilToggle]     _MatCap2ndCustomNormal      ("MatCap Custom Normal Map", Int) = 0
        [Normal]        _MatCap2ndBumpMap           ("Normal Map", 2D) = "bump" {}
                        _MatCap2ndBumpScale         ("Scale", Range(-10,10)) = 1

        //----------------------------------------------------------------------------------------------------------------------
        // Rim
        [lilToggleLeft] _UseRim                     ("Use Rim", Int) = 0
        [lilHDR]        _RimColor                   ("Color", Color) = (1,1,1,1)
        [NoScaleOffset] _RimColorTex                ("Texture", 2D) = "white" {}
                        _RimNormalStrength          ("Normal Strength", Range(0, 1)) = 1.0
                        _RimBorder                  ("Border", Range(0, 1)) = 0.5
                        _RimBlur                    ("Blur", Range(0, 1)) = 0.1
        [PowerSlider(3.0)]_RimFresnelPower          ("Fresnel Power", Range(0.01, 50)) = 3.0
                        _RimEnableLighting          ("Enable Lighting", Range(0, 1)) = 1
                        _RimShadowMask              ("Shadow Mask", Range(0, 1)) = 0
        [lilToggle]     _RimBackfaceMask            ("Backface Mask", Int) = 0
                        _RimVRParallaxStrength      ("VR Parallax Strength", Range(0, 1)) = 1
        [lilToggle]     _RimApplyTransparency       ("Apply Transparency", Int) = 1
                        _RimDirStrength             ("Light direction strength", Range(0, 1)) = 0
                        _RimDirRange                ("Direction range", Range(-1, 1)) = 0
                        _RimIndirRange              ("Indirection range", Range(-1, 1)) = 0
        [lilHDR]        _RimIndirColor              ("Indirection Color", Color) = (1,1,1,1)
                        _RimIndirBorder             ("Indirection Border", Range(0, 1)) = 0.5
                        _RimIndirBlur               ("Indirection Blur", Range(0, 1)) = 0.1

        //----------------------------------------------------------------------------------------------------------------------
        // Glitter
        [lilToggleLeft] _UseGlitter                 ("Use Glitter", Int) = 0
        [lilEnum]       _GlitterUVMode              ("UV Mode|UV0|UV1", Int) = 0
        [lilHDR]        _GlitterColor               ("Color", Color) = (1,1,1,1)
                        _GlitterColorTex            ("Texture", 2D) = "white" {}
                        _GlitterMainStrength        ("Main Color Strength", Range(0, 1)) = 0
                        _GlitterNormalStrength      ("Normal Strength", Range(0, 1)) = 1.0
        [lilGlitParam1] _GlitterParams1             ("Tiling|Particle Size|Contrast", Vector) = (256,256,0.16,50)
        [lilGlitParam2] _GlitterParams2             ("Blink Speed|Angle|Blend Light Direction|Color Randomness", Vector) = (0.25,0,0,0)
                        _GlitterPostContrast        ("Post Contrast", Float) = 1
                        _GlitterEnableLighting      ("Enable Lighting", Range(0, 1)) = 1
                        _GlitterShadowMask          ("Shadow Mask", Range(0, 1)) = 0
        [lilToggle]     _GlitterBackfaceMask        ("Backface Mask", Int) = 0
        [lilToggle]     _GlitterApplyTransparency   ("Apply Transparency", Int) = 1
                        _GlitterVRParallaxStrength  ("VR Parallax Strength", Range(0, 1)) = 1

        //----------------------------------------------------------------------------------------------------------------------
        // Emmision
        [lilToggleLeft] _UseEmission                ("Use Emission", Int) = 0
        [HDR][lilHDR]   _EmissionColor              ("Color", Color) = (1,1,1,1)
                        _EmissionMap                ("Texture", 2D) = "white" {}
        [lilUVAnim]     _EmissionMap_ScrollRotate   ("Angle|UV Animation|Scroll|Rotate", Vector) = (0,0,0,0)
        [lilEnum]       _EmissionMap_UVMode         ("UV Mode|UV0|UV1|UV2|UV3|Rim", Int) = 0
                        _EmissionBlend              ("Blend", Range(0,1)) = 1
                        _EmissionBlendMask          ("Mask", 2D) = "white" {}
        [lilUVAnim]     _EmissionBlendMask_ScrollRotate ("Angle|UV Animation|Scroll|Rotate", Vector) = (0,0,0,0)
        [lilBlink]      _EmissionBlink              ("Blink Strength|Blink Type|Blink Speed|Blink Offset", Vector) = (0,0,3.141593,0)
        [lilToggle]     _EmissionUseGrad            ("Use Gradation", Int) = 0
        [NoScaleOffset] _EmissionGradTex            ("Gradation Texture", 2D) = "white" {}
                        _EmissionGradSpeed          ("Gradation Speed", Float) = 1
                        _EmissionParallaxDepth      ("Parallax Depth", float) = 0
                        _EmissionFluorescence       ("Fluorescence", Range(0,1)) = 0
        // Gradation
        [HideInInspector] _egci ("", Int) = 2
        [HideInInspector] _egai ("", Int) = 2
        [HideInInspector] _egc0 ("", Color) = (1,1,1,0)
        [HideInInspector] _egc1 ("", Color) = (1,1,1,1)
        [HideInInspector] _egc2 ("", Color) = (1,1,1,0)
        [HideInInspector] _egc3 ("", Color) = (1,1,1,0)
        [HideInInspector] _egc4 ("", Color) = (1,1,1,0)
        [HideInInspector] _egc5 ("", Color) = (1,1,1,0)
        [HideInInspector] _egc6 ("", Color) = (1,1,1,0)
        [HideInInspector] _egc7 ("", Color) = (1,1,1,0)
        [HideInInspector] _ega0 ("", Color) = (1,0,0,0)
        [HideInInspector] _ega1 ("", Color) = (1,0,0,1)
        [HideInInspector] _ega2 ("", Color) = (1,0,0,0)
        [HideInInspector] _ega3 ("", Color) = (1,0,0,0)
        [HideInInspector] _ega4 ("", Color) = (1,0,0,0)
        [HideInInspector] _ega5 ("", Color) = (1,0,0,0)
        [HideInInspector] _ega6 ("", Color) = (1,0,0,0)
        [HideInInspector] _ega7 ("", Color) = (1,0,0,0)

        //----------------------------------------------------------------------------------------------------------------------
        // Emmision2nd
        [lilToggleLeft] _UseEmission2nd             ("Use Emission 2nd", Int) = 0
        [HDR][lilHDR]   _Emission2ndColor           ("Color", Color) = (1,1,1,1)
                        _Emission2ndMap             ("Texture", 2D) = "white" {}
        [lilUVAnim]     _Emission2ndMap_ScrollRotate ("Angle|UV Animation|Scroll|Rotate", Vector) = (0,0,0,0)
        [lilEnum]       _Emission2ndMap_UVMode      ("UV Mode|UV0|UV1|UV2|UV3|Rim", Int) = 0
                        _Emission2ndBlend           ("Blend", Range(0,1)) = 1
                        _Emission2ndBlendMask       ("Mask", 2D) = "white" {}
        [lilUVAnim]     _Emission2ndBlendMask_ScrollRotate ("Angle|UV Animation|Scroll|Rotate", Vector) = (0,0,0,0)
        [lilBlink]      _Emission2ndBlink           ("Blink Strength|Blink Type|Blink Speed|Blink Offset", Vector) = (0,0,3.141593,0)
        [lilToggle]     _Emission2ndUseGrad         ("Use Gradation", Int) = 0
        [NoScaleOffset] _Emission2ndGradTex         ("Gradation Texture", 2D) = "white" {}
                        _Emission2ndGradSpeed       ("Gradation Speed", Float) = 1
                        _Emission2ndParallaxDepth   ("Parallax Depth", float) = 0
                        _Emission2ndFluorescence    ("Fluorescence", Range(0,1)) = 0
        // Gradation
        [HideInInspector] _e2gci ("", Int) = 2
        [HideInInspector] _e2gai ("", Int) = 2
        [HideInInspector] _e2gc0 ("", Color) = (1,1,1,0)
        [HideInInspector] _e2gc1 ("", Color) = (1,1,1,1)
        [HideInInspector] _e2gc2 ("", Color) = (1,1,1,0)
        [HideInInspector] _e2gc3 ("", Color) = (1,1,1,0)
        [HideInInspector] _e2gc4 ("", Color) = (1,1,1,0)
        [HideInInspector] _e2gc5 ("", Color) = (1,1,1,0)
        [HideInInspector] _e2gc6 ("", Color) = (1,1,1,0)
        [HideInInspector] _e2gc7 ("", Color) = (1,1,1,0)
        [HideInInspector] _e2ga0 ("", Color) = (1,0,0,0)
        [HideInInspector] _e2ga1 ("", Color) = (1,0,0,1)
        [HideInInspector] _e2ga2 ("", Color) = (1,0,0,0)
        [HideInInspector] _e2ga3 ("", Color) = (1,0,0,0)
        [HideInInspector] _e2ga4 ("", Color) = (1,0,0,0)
        [HideInInspector] _e2ga5 ("", Color) = (1,0,0,0)
        [HideInInspector] _e2ga6 ("", Color) = (1,0,0,0)
        [HideInInspector] _e2ga7 ("", Color) = (1,0,0,0)

        //----------------------------------------------------------------------------------------------------------------------
        // Parallax
        [lilToggleLeft] _UseParallax                ("Use Parallax", Int) = 0
        [NoScaleOffset] _ParallaxMap                ("Parallax Map", 2D) = "gray" {}
                        _Parallax                   ("Parallax Scale", float) = 0.02
                        _ParallaxOffset             ("Parallax Offset", float) = 0.5

        //----------------------------------------------------------------------------------------------------------------------
        // Distance Fade
        [lilHDR]        _DistanceFadeColor          ("Color", Color) = (0,0,0,1)
        [lilFFFB]       _DistanceFade               ("Start|End|Strength|Fix backface", Vector) = (0.1,0.01,0,0)

        //----------------------------------------------------------------------------------------------------------------------
        // AudioLink
        [lilToggleLeft] _UseAudioLink               ("Use AudioLink", Int) = 0
        [lilFRFR]       _AudioLinkDefaultValue      ("Strength|Blink Strength|Blink Speed|Blink Threshold", Vector) = (0.0,0.0,2.0,0.75)
        [lilEnum]       _AudioLinkUVMode            ("UV Mode|None|Rim|UV|Mask|Mask Spectrum|Position", Int) = 1
        [lilALUVParams] _AudioLinkUVParams          ("Scale|Offset|Angle|Band|Bass|Low Mid|High Mid|Treble", Vector) = (0.25,0,0,0.125)
        [lilVec3]       _AudioLinkStart             ("Start Position", Vector) = (0.0,0.0,0.0,0.0)
        [NoScaleOffset] _AudioLinkMask              ("Mask", 2D) = "blue" {}
        [lilToggle]     _AudioLink2Main2nd          ("Main 2nd", Int) = 0
        [lilToggle]     _AudioLink2Main3rd          ("Main 3rd", Int) = 0
        [lilToggle]     _AudioLink2Emission         ("Emission", Int) = 0
        [lilToggle]     _AudioLink2EmissionGrad     ("Emission Grad", Int) = 0
        [lilToggle]     _AudioLink2Emission2nd      ("Emission 2nd", Int) = 0
        [lilToggle]     _AudioLink2Emission2ndGrad  ("Emission 2nd Grad", Int) = 0
        [lilToggle]     _AudioLink2Vertex           ("Vertex", Int) = 0
        [lilEnum]       _AudioLinkVertexUVMode      ("UV Mode|None|Position|UV|Mask", Int) = 1
        [lilALUVParams] _AudioLinkVertexUVParams    ("Scale|Offset|Angle|Band|Bass|Low Mid|High Mid|Treble", Vector) = (0.25,0,0,0.125)
        [lilVec3]       _AudioLinkVertexStart       ("Start Position", Vector) = (0.0,0.0,0.0,0.0)
        [lilVec3Float]  _AudioLinkVertexStrength    ("Moving Vector|Normal Strength", Vector) = (0.0,0.0,0.0,1.0)
        [lilToggle]     _AudioLinkAsLocal           ("As Local", Int) = 0
        [NoScaleOffset] _AudioLinkLocalMap          ("Local Map", 2D) = "black" {}
        [lilALLocal]    _AudioLinkLocalMapParams    ("BPM|Notes|Offset", Vector) = (120,1,0,0)

        //----------------------------------------------------------------------------------------------------------------------
        // Dissolve
                        _DissolveMask               ("Dissolve Mask", 2D) = "white" {}
                        _DissolveNoiseMask          ("Dissolve Noise Mask", 2D) = "gray" {}
        [lilUVAnim]     _DissolveNoiseMask_ScrollRotate ("Scroll", Vector) = (0,0,0,0)
                        _DissolveNoiseStrength      ("Dissolve Noise Strength", float) = 0.1
        [lilHDR]        _DissolveColor              ("Dissolve Color", Color) = (1,1,1,1)
        [lilDissolve]   _DissolveParams             ("Dissolve Mode|None|Alpha|UV|Position|Dissolve Shape|Point|Line|Border|Blur", Vector) = (0,0,0.5,0.1)
        [lilDissolveP]  _DissolvePos                ("Dissolve Position", Vector) = (0,0,0,0)

        //----------------------------------------------------------------------------------------------------------------------
        // Encryption
        [lilToggle]     _IgnoreEncryption           ("Ignore Encryption", Int) = 0
                        _Keys                       ("Keys", Vector) = (0,0,0,0)

        //----------------------------------------------------------------------------------------------------------------------
        // Advanced
        [lilEnum]                                       _Cull               ("Cull Mode|Off|Front|Back", Int) = 2
        [Enum(UnityEngine.Rendering.BlendMode)]         _SrcBlend           ("SrcBlend", Int) = 1
        [Enum(UnityEngine.Rendering.BlendMode)]         _DstBlend           ("DstBlend", Int) = 10
        [Enum(UnityEngine.Rendering.BlendMode)]         _SrcBlendAlpha      ("SrcBlendAlpha", Int) = 1
        [Enum(UnityEngine.Rendering.BlendMode)]         _DstBlendAlpha      ("DstBlendAlpha", Int) = 10
        [Enum(UnityEngine.Rendering.BlendOp)]           _BlendOp            ("BlendOp", Int) = 0
        [Enum(UnityEngine.Rendering.BlendOp)]           _BlendOpAlpha       ("BlendOpAlpha", Int) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]         _SrcBlendFA         ("ForwardAdd SrcBlend", Int) = 1
        [Enum(UnityEngine.Rendering.BlendMode)]         _DstBlendFA         ("ForwardAdd DstBlend", Int) = 1
        [Enum(UnityEngine.Rendering.BlendMode)]         _SrcBlendAlphaFA    ("ForwardAdd SrcBlendAlpha", Int) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]         _DstBlendAlphaFA    ("ForwardAdd DstBlendAlpha", Int) = 1
        [Enum(UnityEngine.Rendering.BlendOp)]           _BlendOpFA          ("ForwardAdd BlendOp", Int) = 4
        [Enum(UnityEngine.Rendering.BlendOp)]           _BlendOpAlphaFA     ("ForwardAdd BlendOpAlpha", Int) = 4
        [lilToggle]                                     _ZClip              ("ZClip", Int) = 1
        [lilToggle]                                     _ZWrite             ("ZWrite", Int) = 1
        [Enum(UnityEngine.Rendering.CompareFunction)]   _ZTest              ("ZTest", Int) = 4
        [IntRange]                                      _StencilRef         ("Stencil Reference Value", Range(0, 255)) = 0
        [IntRange]                                      _StencilReadMask    ("Stencil ReadMask Value", Range(0, 255)) = 255
        [IntRange]                                      _StencilWriteMask   ("Stencil WriteMask Value", Range(0, 255)) = 255
        [Enum(UnityEngine.Rendering.CompareFunction)]   _StencilComp        ("Stencil Compare Function", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)]         _StencilPass        ("Stencil Pass", Float) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]         _StencilFail        ("Stencil Fail", Float) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]         _StencilZFail       ("Stencil ZFail", Float) = 0
                                                        _OffsetFactor       ("Offset Factor", Float) = 0
                                                        _OffsetUnits        ("Offset Units", Float) = 0
        [lilColorMask]                                  _ColorMask          ("Color Mask", Int) = 15
        [lilToggle]                                     _AlphaToMask        ("AlphaToMask", Int) = 0
                                                        _lilShadowCasterBias ("Shadow Caster Bias", Float) = 0

        //----------------------------------------------------------------------------------------------------------------------
        // Fur
                        _FurNoiseMask               ("Fur Noise", 2D) = "white" {}
        [NoScaleOffset] _FurMask                    ("Fur Mask", 2D) = "white" {}
        [NoScaleOffset] _FurLengthMask              ("Fur Length Mask", 2D) = "white" {}
        [NoScaleOffset][Normal] _FurVectorTex       ("Fur Vector", 2D) = "bump" {}
                        _FurVectorScale             ("Fur Vector scale", Range(-10,10)) = 1
        [lilVec3Float]  _FurVector                  ("Fur Vector|Fur Length", Vector) = (0.0,0.0,1.0,0.2)
        [lilToggle]     _VertexColor2FurVector      ("VertexColor->Vector", Int) = 0
                        _FurGravity                 ("Fur Gravity", Range(0,1)) = 0.25
                        _FurRandomize               ("Fur Randomize", Float) = 0
                        _FurAO                      ("Fur AO", Range(0,1)) = 0
        [IntRange]      _FurLayerNum                ("Fur Layer Num", Range(1, 6)) = 2
                        _FurRootOffset              ("Fur Root Offset", Range(-1,0)) = 0
                        _FurCutoutLength            ("Fur Cutout Length", Float) = 0.8
                        _FurTouchStrength           ("Fur Touch Strength", Range(0, 1)) = 0

        //----------------------------------------------------------------------------------------------------------------------
        // Fur Advanced
        [lilCullMode]                                   _FurCull                ("Cull Mode|Off|Front|Back", Int) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]         _FurSrcBlend            ("SrcBlend", Int) = 5
        [Enum(UnityEngine.Rendering.BlendMode)]         _FurDstBlend            ("DstBlend", Int) = 10
        [Enum(UnityEngine.Rendering.BlendMode)]         _FurSrcBlendAlpha       ("SrcBlendAlpha", Int) = 1
        [Enum(UnityEngine.Rendering.BlendMode)]         _FurDstBlendAlpha       ("DstBlendAlpha", Int) = 10
        [Enum(UnityEngine.Rendering.BlendOp)]           _FurBlendOp             ("BlendOp", Int) = 0
        [Enum(UnityEngine.Rendering.BlendOp)]           _FurBlendOpAlpha        ("BlendOpAlpha", Int) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]         _FurSrcBlendFA          ("ForwardAdd SrcBlend", Int) = 1
        [Enum(UnityEngine.Rendering.BlendMode)]         _FurDstBlendFA          ("ForwardAdd DstBlend", Int) = 1
        [Enum(UnityEngine.Rendering.BlendMode)]         _FurSrcBlendAlphaFA     ("ForwardAdd SrcBlendAlpha", Int) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]         _FurDstBlendAlphaFA     ("ForwardAdd DstBlendAlpha", Int) = 1
        [Enum(UnityEngine.Rendering.BlendOp)]           _FurBlendOpFA           ("ForwardAdd BlendOp", Int) = 4
        [Enum(UnityEngine.Rendering.BlendOp)]           _FurBlendOpAlphaFA      ("ForwardAdd BlendOpAlpha", Int) = 4
        [lilToggle]                                     _FurZClip               ("ZClip", Int) = 1
        [lilToggle]                                     _FurZWrite              ("ZWrite", Int) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)]   _FurZTest               ("ZTest", Int) = 4
        [IntRange]                                      _FurStencilRef          ("Stencil Reference Value", Range(0, 255)) = 0
        [IntRange]                                      _FurStencilReadMask     ("Stencil ReadMask Value", Range(0, 255)) = 255
        [IntRange]                                      _FurStencilWriteMask    ("Stencil WriteMask Value", Range(0, 255)) = 255
        [Enum(UnityEngine.Rendering.CompareFunction)]   _FurStencilComp         ("Stencil Compare Function", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)]         _FurStencilPass         ("Stencil Pass", Float) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]         _FurStencilFail         ("Stencil Fail", Float) = 0
        [Enum(UnityEngine.Rendering.StencilOp)]         _FurStencilZFail        ("Stencil ZFail", Float) = 0
                                                        _FurOffsetFactor        ("Offset Factor", Float) = 0
                                                        _FurOffsetUnits         ("Offset Units", Float) = 0
        [lilColorMask]                                  _FurColorMask           ("Color Mask", Int) = 15
        [lilToggle]                                     _FurAlphaToMask         ("AlphaToMask", Int) = 0

        //----------------------------------------------------------------------------------------------------------------------
        // For Multi
        [lilToggleLeft] _UseOutline                 ("Use Outline", Int) = 0
        [lilEnum]       _TransparentMode            ("Rendering Mode|Opaque|Cutout|Transparent|Refraction|Fur|FurCutout|Gem", Int) = 0
        [lilToggle]     _UsePOM                     ("Use POM", Int) = 0
        [lilToggle]     _UseClippingCanceller       ("Use Clipping Canceller", Int) = 0
        [lilToggle]     _AsOverlay                  ("As Overlay", Int) = 0

        //----------------------------------------------------------------------------------------------------------------------
        // Save (Unused)
        [HideInInspector] [MainColor]                   _BaseColor          ("Color", Color) = (1,1,1,1)
        [HideInInspector] [MainTexture]                 _BaseMap            ("Texture", 2D) = "white" {}
        [HideInInspector]                               _BaseColorMap       ("Texture", 2D) = "white" {}
        [HideInInspector]                               _lilToonVersion     ("Version", Int) = 0
    }
    HLSLINCLUDE
        #pragma require geometry
        #define LIL_FUR
        #define LIL_MULTI
        #define LIL_MULTI_INPUTS_MAIN_TONECORRECTION
        #define LIL_MULTI_INPUTS_MAIN2ND
        #define LIL_MULTI_INPUTS_MAIN3RD
        #define LIL_MULTI_INPUTS_ALPHAMASK
        #define LIL_MULTI_INPUTS_SHADOW
        #define LIL_MULTI_INPUTS_BACKLIGHT
        #define LIL_MULTI_INPUTS_EMISSION
        #define LIL_MULTI_INPUTS_EMISSION_2ND
        #define LIL_MULTI_INPUTS_NORMAL
        #define LIL_MULTI_INPUTS_NORMAL_2ND
        #define LIL_MULTI_INPUTS_ANISOTROPY
        #define LIL_MULTI_INPUTS_REFLECTION
        #define LIL_MULTI_INPUTS_MATCAP
        #define LIL_MULTI_INPUTS_MATCAP_2ND
        #define LIL_MULTI_INPUTS_RIM
        #define LIL_MULTI_INPUTS_GLITTER
        #define LIL_MULTI_INPUTS_PARALLAX
        #define LIL_MULTI_INPUTS_DISTANCE_FADE
        #define LIL_MULTI_INPUTS_AUDIOLINK
        #define LIL_MULTI_INPUTS_DISSOLVE
    ENDHLSL

//----------------------------------------------------------------------------------------------------------------------
// BRP Start
//
    SubShader
    {
        Tags {"RenderType" = "Transparent" "Queue" = "Transparent"}

        // Forward
        Pass
        {
            Name "FORWARD"
            Tags {"LightMode" = "ForwardBase"}

            Stencil
            {
                Ref [_StencilRef]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
                Comp [_StencilComp]
                Pass [_StencilPass]
                Fail [_StencilFail]
                ZFail [_StencilZFail]
            }
            Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            ColorMask [_ColorMask]
            Offset [_OffsetFactor], [_OffsetUnits]
            BlendOp [_BlendOp], [_BlendOpAlpha]
            Blend [_SrcBlend] [_DstBlend], [_SrcBlendAlpha] [_DstBlendAlpha]
            AlphaToMask [_AlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdbase
            #pragma multi_compile_vertex _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma skip_variants DIRLIGHTMAP_COMBINED

            // Skip vertex light
            //#pragma skip_variants VERTEXLIGHT_ON

            // Skip lightmap
            #pragma skip_variants LIGHTMAP_ON DYNAMICLIGHTMAP_ON LIGHTMAP_SHADOW_MIXING SHADOWS_SHADOWMASK

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_ALPHACLIP
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // AlphaMask and Dissolve
            #pragma shader_feature_local _COLOROVERLAY_ON
            #pragma shader_feature_local GEOM_TYPE_BRANCH_DETAIL

            // Main
            #pragma shader_feature_local EFFECT_HUE_VARIATION
            #pragma shader_feature_local _COLORADDSUBDIFF_ON
            #pragma shader_feature_local _COLORCOLOR_ON
            #pragma shader_feature_local _SUNDISK_NONE
            #pragma shader_feature_local GEOM_TYPE_FROND
            #pragma shader_feature_local _REQUIRE_UV2
            #pragma shader_feature_local ANTI_FLICKER
            #pragma shader_feature_local _EMISSION
            #pragma shader_feature_local GEOM_TYPE_BRANCH
            #pragma shader_feature_local _SUNDISK_SIMPLE
            #pragma shader_feature_local _NORMALMAP
            #pragma shader_feature_local EFFECT_BUMP
            #pragma shader_feature_local SOURCE_GBUFFER
            #pragma shader_feature_local _GLOSSYREFLECTIONS_OFF
            #pragma shader_feature_local _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            #pragma shader_feature_local _SPECULARHIGHLIGHTS_OFF
            #pragma shader_feature_local GEOM_TYPE_MESH
            #pragma shader_feature_local _METALLICGLOSSMAP
            #pragma shader_feature_local GEOM_TYPE_LEAF
            #pragma shader_feature_local _SPECGLOSSMAP
            #pragma shader_feature_local _PARALLAXMAP
            #pragma shader_feature_local PIXELSNAP_ON
            #pragma shader_feature_local _FADING_ON
            #pragma shader_feature_local _MAPPING_6_FRAMES_LAYOUT
            #pragma shader_feature_local _SUNDISK_HIGH_QUALITY

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_brp.hlsl"
            #include "Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        // Forward Fur
        Pass
        {
            Name "FORWARD_FUR"
            Tags {"LightMode" = "ForwardBase"}

            Stencil
            {
                Ref [_FurStencilRef]
                ReadMask [_FurStencilReadMask]
                WriteMask [_FurStencilWriteMask]
                Comp [_FurStencilComp]
                Pass [_FurStencilPass]
                Fail [_FurStencilFail]
                ZFail [_FurStencilZFail]
            }
            Cull [_FurCull]
            ZClip [_FurZClip]
            ZWrite [_FurZWrite]
            ZTest [_FurZTest]
            ColorMask [_FurColorMask]
            Offset [_FurOffsetFactor], [_FurOffsetUnits]
            BlendOp [_FurBlendOp], [_FurBlendOpAlpha]
            Blend [_FurSrcBlend] [_FurDstBlend], [_FurSrcBlendAlpha] [_FurDstBlendAlpha]
            AlphaToMask [_FurAlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma geometry geom
            #pragma fragment frag
            #pragma multi_compile_fwdbase
            #pragma multi_compile_vertex _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma skip_variants SHADOWS_SCREEN

            // Skip vertex light
            //#pragma skip_variants VERTEXLIGHT_ON

            // Skip lightmap
            #pragma skip_variants LIGHTMAP_ON DYNAMICLIGHTMAP_ON LIGHTMAP_SHADOW_MIXING SHADOWS_SHADOWMASK

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // Main
            #pragma shader_feature_local _REQUIRE_UV2
            #pragma shader_feature_local _FADING_ON

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_brp.hlsl"
            #include "Includes/lil_pass_forward_fur.hlsl"

            ENDHLSL
        }

        //----------------------------------------------------------------------------------------------------------------------
        // ForwardAdd Start
        //

        // ForwardAdd
        Pass
        {
            Name "FORWARD_ADD"
            Tags {"LightMode" = "ForwardAdd"}

            Stencil
            {
                Ref [_StencilRef]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
                Comp [_StencilComp]
                Pass [_StencilPass]
                Fail [_StencilFail]
                ZFail [_StencilZFail]
            }
		    Cull [_Cull]
            ZClip [_ZClip]
			ZWrite Off
            ZTest LEqual
            ColorMask [_ColorMask]
            Offset [_OffsetFactor], [_OffsetUnits]
            Blend [_SrcBlendFA] [_DstBlendFA], Zero One
            BlendOp [_BlendOpFA], [_BlendOpAlphaFA]
            AlphaToMask [_AlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fragment POINT DIRECTIONAL SPOT POINT_COOKIE DIRECTIONAL_COOKIE
            #pragma multi_compile_vertex _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing
            #pragma fragmentoption ARB_precision_hint_fastest

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_ALPHACLIP
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // AlphaMask and Dissolve
            #pragma shader_feature_local _COLOROVERLAY_ON
            #pragma shader_feature_local GEOM_TYPE_BRANCH_DETAIL

            // Main
            #pragma shader_feature_local EFFECT_HUE_VARIATION
            #pragma shader_feature_local _COLORADDSUBDIFF_ON
            #pragma shader_feature_local _COLORCOLOR_ON
            #pragma shader_feature_local _SUNDISK_NONE
            #pragma shader_feature_local GEOM_TYPE_FROND
            #pragma shader_feature_local _REQUIRE_UV2
            #pragma shader_feature_local _NORMALMAP
            #pragma shader_feature_local EFFECT_BUMP
            #pragma shader_feature_local SOURCE_GBUFFER
            #pragma shader_feature_local _GLOSSYREFLECTIONS_OFF
            #pragma shader_feature_local _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            #pragma shader_feature_local _SPECULARHIGHLIGHTS_OFF
            #pragma shader_feature_local GEOM_TYPE_MESH
            #pragma shader_feature_local _METALLICGLOSSMAP
            #pragma shader_feature_local GEOM_TYPE_LEAF
            #pragma shader_feature_local _SPECGLOSSMAP
            #pragma shader_feature_local _PARALLAXMAP
            #pragma shader_feature_local PIXELSNAP_ON
            #pragma shader_feature_local _FADING_ON
            #pragma shader_feature_local _MAPPING_6_FRAMES_LAYOUT
            #pragma shader_feature_local _SUNDISK_HIGH_QUALITY

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #define LIL_PASS_FORWARDADD
            #include "Includes/lil_pipeline_brp.hlsl"
            #include "Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        // ForwardAdd Fur
        Pass
        {
            Name "FORWARD_ADD_FUR"
            Tags {"LightMode" = "ForwardAdd"}

            Stencil
            {
                Ref [_FurStencilRef]
                ReadMask [_FurStencilReadMask]
                WriteMask [_FurStencilWriteMask]
                Comp [_FurStencilComp]
                Pass [_FurStencilPass]
                Fail [_FurStencilFail]
                ZFail [_FurStencilZFail]
            }
		    Cull [_FurCull]
            ZClip [_FurZClip]
			ZWrite Off
            ZTest LEqual
            ColorMask [_FurColorMask]
            Offset [_FurOffsetFactor], [_FurOffsetUnits]
            Blend [_FurSrcBlendFA] [_FurDstBlendFA], Zero One
            BlendOp [_FurBlendOpFA], [_FurBlendOpAlphaFA]
            AlphaToMask [_FurAlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma geometry geom
            #pragma fragment frag
            #pragma multi_compile_fragment POINT DIRECTIONAL SPOT POINT_COOKIE DIRECTIONAL_COOKIE
            #pragma multi_compile_vertex _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing
            #pragma fragmentoption ARB_precision_hint_fastest

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // Main
            #pragma shader_feature_local _REQUIRE_UV2
            #pragma shader_feature_local _FADING_ON

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #define LIL_PASS_FORWARDADD
            #include "Includes/lil_pipeline_brp.hlsl"
            #include "Includes/lil_pass_forward_fur.hlsl"

            ENDHLSL
        }

        //
        // ForwardAdd End

        // ShadowCaster
        Pass
        {
            Name "SHADOW_CASTER"
            Tags {"LightMode" = "ShadowCaster"}
            Offset 1, 1
		    Cull [_Cull]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_instancing

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_ALPHACLIP
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // AlphaMask and Dissolve
            #pragma shader_feature_local _COLOROVERLAY_ON
            #pragma shader_feature_local GEOM_TYPE_BRANCH_DETAIL

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_brp.hlsl"
            #include "Includes/lil_pass_shadowcaster.hlsl"

            ENDHLSL
        }

        // Meta
        Pass
        {
            Name "META"
            Tags {"LightMode" = "Meta"}
            Cull Off

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma shader_feature EDITOR_VISUALIZATION

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_brp.hlsl"
            #include "Includes/lil_pass_meta.hlsl"
            ENDHLSL
        }
    }
    Fallback "Unlit/Texture"
//
// BRP End

//----------------------------------------------------------------------------------------------------------------------
// LWRP Start
/*
    SubShader
    {
        Tags {"RenderType" = "Transparent" "Queue" = "Transparent"}

        // Forward
        Pass
        {
            Name "FORWARD"
            Tags {"LightMode" = "LightweightForward"}

            Stencil
            {
                Ref [_StencilRef]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
                Comp [_StencilComp]
                Pass [_StencilPass]
                Fail [_StencilFail]
                ZFail [_StencilZFail]
            }
            Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            ColorMask [_ColorMask]
            Offset [_OffsetFactor], [_OffsetUnits]
            BlendOp [_BlendOp], [_BlendOpAlpha]
            Blend [_SrcBlend] [_DstBlend], [_SrcBlendAlpha] [_DstBlendAlpha]
            AlphaToMask [_AlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _MIXED_LIGHTING_SUBTRACTIVE
            #pragma multi_compile_fragment _ LIGHTMAP_ON
            #pragma multi_compile_vertex _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing

            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
            #pragma multi_compile_fragment _ _SHADOWS_SOFT

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_ALPHACLIP
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // AlphaMask and Dissolve
            #pragma shader_feature_local _COLOROVERLAY_ON
            #pragma shader_feature_local GEOM_TYPE_BRANCH_DETAIL

            // Main
            #pragma shader_feature_local EFFECT_HUE_VARIATION
            #pragma shader_feature_local _COLORADDSUBDIFF_ON
            #pragma shader_feature_local _COLORCOLOR_ON
            #pragma shader_feature_local _SUNDISK_NONE
            #pragma shader_feature_local GEOM_TYPE_FROND
            #pragma shader_feature_local _REQUIRE_UV2
            #pragma shader_feature_local ANTI_FLICKER
            #pragma shader_feature_local _EMISSION
            #pragma shader_feature_local GEOM_TYPE_BRANCH
            #pragma shader_feature_local _SUNDISK_SIMPLE
            #pragma shader_feature_local _NORMALMAP
            #pragma shader_feature_local EFFECT_BUMP
            #pragma shader_feature_local SOURCE_GBUFFER
            #pragma shader_feature_local _GLOSSYREFLECTIONS_OFF
            #pragma shader_feature_local _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            #pragma shader_feature_local _SPECULARHIGHLIGHTS_OFF
            #pragma shader_feature_local GEOM_TYPE_MESH
            #pragma shader_feature_local _METALLICGLOSSMAP
            #pragma shader_feature_local GEOM_TYPE_LEAF
            #pragma shader_feature_local _SPECGLOSSMAP
            #pragma shader_feature_local _PARALLAXMAP
            #pragma shader_feature_local PIXELSNAP_ON
            #pragma shader_feature_local _FADING_ON
            #pragma shader_feature_local _MAPPING_6_FRAMES_LAYOUT
            #pragma shader_feature_local _SUNDISK_HIGH_QUALITY

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_lwrp.hlsl"
            #include "Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        // Fur
        Pass
        {
            Name "FORWARD_FUR"
            Tags {"LightMode" = "LightweightForward"}

            Stencil
            {
                Ref [_FurStencilRef]
                ReadMask [_FurStencilReadMask]
                WriteMask [_FurStencilWriteMask]
                Comp [_FurStencilComp]
                Pass [_FurStencilPass]
                Fail [_FurStencilFail]
                ZFail [_FurStencilZFail]
            }
            Cull [_FurCull]
            ZClip [_FurZClip]
            ZWrite [_FurZWrite]
            ZTest [_FurZTest]
            ColorMask [_FurColorMask]
            Offset [_FurOffsetFactor], [_FurOffsetUnits]
            BlendOp [_FurBlendOp], [_FurBlendOpAlpha]
            Blend [_FurSrcBlend] [_FurDstBlend], [_FurSrcBlendAlpha] [_FurDstBlendAlpha]
            AlphaToMask [_FurAlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma geometry geom
            #pragma fragment frag
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _MIXED_LIGHTING_SUBTRACTIVE
            #pragma multi_compile_fragment _ LIGHTMAP_ON
            #pragma multi_compile_vertex _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // Main
            #pragma shader_feature_local _REQUIRE_UV2
            #pragma shader_feature_local _FADING_ON

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_lwrp.hlsl"
            #include "Includes/lil_pass_forward_fur.hlsl"

            ENDHLSL
        }

        // ShadowCaster
        Pass
        {
            Name "SHADOW_CASTER"
            Tags {"LightMode" = "ShadowCaster"}
		    Cull [_Cull]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_lwrp.hlsl"
            #include "Includes/lil_pass_shadowcaster.hlsl"

            ENDHLSL
        }

        // DepthOnly
        Pass
        {
            Name "DEPTHONLY"
            Tags {"LightMode" = "DepthOnly"}
		    Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_ALPHACLIP
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // AlphaMask and Dissolve
            #pragma shader_feature_local _COLOROVERLAY_ON
            #pragma shader_feature_local GEOM_TYPE_BRANCH_DETAIL

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_lwrp.hlsl"
            #include "Includes/lil_pass_depthonly.hlsl"

            ENDHLSL
        }

        // Meta
        Pass
        {
            Name "META"
            Tags {"LightMode" = "Meta"}
            Cull Off

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag

            // Tone correction and emission
            #pragma shader_feature_local EFFECT_HUE_VARIATION
            #pragma shader_feature_local _EMISSION
            #pragma shader_feature_local GEOM_TYPE_BRANCH
            #pragma shader_feature_local _SUNDISK_SIMPLE

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_lwrp.hlsl"
            #include "Includes/lil_pass_meta.hlsl"
            ENDHLSL
        }
    }
    Fallback "Lightweight Render Pipeline/Unlit"
*/
// LWRP End

//----------------------------------------------------------------------------------------------------------------------
// URP Start
/*
    //----------------------------------------------------------------------------------------------------------------------
    // Universal Render Pipeline SM4.5
    SubShader
    {
        Tags {"RenderType" = "Transparent" "Queue" = "Transparent" "ShaderModel" = "4.5"}
        HLSLINCLUDE
            #pragma target 4.5
            #pragma exclude_renderers gles gles3 glcore
        ENDHLSL

        // Forward
        Pass
        {
            Name "FORWARD"
            Tags {"LightMode" = "UniversalForward"}

            Stencil
            {
                Ref [_StencilRef]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
                Comp [_StencilComp]
                Pass [_StencilPass]
                Fail [_StencilFail]
                ZFail [_StencilZFail]
            }
            Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            ColorMask [_ColorMask]
            Offset [_OffsetFactor], [_OffsetUnits]
            BlendOp [_BlendOp], [_BlendOpAlpha]
            Blend [_SrcBlend] [_DstBlend], [_SrcBlendAlpha] [_DstBlendAlpha]
            AlphaToMask [_AlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile _ _LIGHT_LAYERS
            #pragma multi_compile _ _CLUSTERED_RENDERING
            #pragma multi_compile_fragment _ _LIGHT_COOKIES
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
            #pragma multi_compile_fragment _ LIGHTMAP_SHADOW_MIXING
            #pragma multi_compile_fragment _ SHADOWS_SHADOWMASK
            #pragma multi_compile_fragment _ LIGHTMAP_ON
            #pragma multi_compile_fragment _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile_vertex _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
            #pragma multi_compile_fragment _ _SHADOWS_SOFT

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_ALPHACLIP
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // AlphaMask and Dissolve
            #pragma shader_feature_local _COLOROVERLAY_ON
            #pragma shader_feature_local GEOM_TYPE_BRANCH_DETAIL

            // Main
            #pragma shader_feature_local EFFECT_HUE_VARIATION
            #pragma shader_feature_local _COLORADDSUBDIFF_ON
            #pragma shader_feature_local _COLORCOLOR_ON
            #pragma shader_feature_local _SUNDISK_NONE
            #pragma shader_feature_local GEOM_TYPE_FROND
            #pragma shader_feature_local _REQUIRE_UV2
            #pragma shader_feature_local ANTI_FLICKER
            #pragma shader_feature_local _EMISSION
            #pragma shader_feature_local GEOM_TYPE_BRANCH
            #pragma shader_feature_local _SUNDISK_SIMPLE
            #pragma shader_feature_local _NORMALMAP
            #pragma shader_feature_local EFFECT_BUMP
            #pragma shader_feature_local SOURCE_GBUFFER
            #pragma shader_feature_local _GLOSSYREFLECTIONS_OFF
            #pragma shader_feature_local _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            #pragma shader_feature_local _SPECULARHIGHLIGHTS_OFF
            #pragma shader_feature_local GEOM_TYPE_MESH
            #pragma shader_feature_local _METALLICGLOSSMAP
            #pragma shader_feature_local GEOM_TYPE_LEAF
            #pragma shader_feature_local _SPECGLOSSMAP
            #pragma shader_feature_local _PARALLAXMAP
            #pragma shader_feature_local PIXELSNAP_ON
            #pragma shader_feature_local _FADING_ON
            #pragma shader_feature_local _MAPPING_6_FRAMES_LAYOUT
            #pragma shader_feature_local _SUNDISK_HIGH_QUALITY

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        // Fur
        Pass
        {
            Name "FORWARD_FUR"
            Tags {"LightMode" = "UniversalForward"}

            Stencil
            {
                Ref [_FurStencilRef]
                ReadMask [_FurStencilReadMask]
                WriteMask [_FurStencilWriteMask]
                Comp [_FurStencilComp]
                Pass [_FurStencilPass]
                Fail [_FurStencilFail]
                ZFail [_FurStencilZFail]
            }
            Cull [_FurCull]
            ZClip [_FurZClip]
            ZWrite [_FurZWrite]
            ZTest [_FurZTest]
            ColorMask [_FurColorMask]
            Offset [_FurOffsetFactor], [_FurOffsetUnits]
            BlendOp [_FurBlendOp], [_FurBlendOpAlpha]
            Blend [_FurSrcBlend] [_FurDstBlend], [_FurSrcBlendAlpha] [_FurDstBlendAlpha]
            AlphaToMask [_FurAlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma geometry geom
            #pragma fragment frag
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile _ _LIGHT_LAYERS
            #pragma multi_compile _ _CLUSTERED_RENDERING
            #pragma multi_compile_fragment _ _LIGHT_COOKIES
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
            #pragma multi_compile_fragment _ LIGHTMAP_SHADOW_MIXING
            #pragma multi_compile_fragment _ SHADOWS_SHADOWMASK
            #pragma multi_compile_fragment _ LIGHTMAP_ON
            #pragma multi_compile_fragment _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile_vertex _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ DOTS_INSTANCING_ON

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // Main
            #pragma shader_feature_local _REQUIRE_UV2
            #pragma shader_feature_local _FADING_ON

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_forward_fur.hlsl"

            ENDHLSL
        }

        // ShadowCaster
        Pass
        {
            Name "SHADOW_CASTER"
            Tags {"LightMode" = "ShadowCaster"}
		    Cull [_Cull]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW
            #pragma multi_compile_instancing
            #pragma multi_compile _ DOTS_INSTANCING_ON

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_ALPHACLIP
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // AlphaMask and Dissolve
            #pragma shader_feature_local _COLOROVERLAY_ON
            #pragma shader_feature_local GEOM_TYPE_BRANCH_DETAIL

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_shadowcaster.hlsl"

            ENDHLSL
        }

        // DepthOnly
        Pass
        {
            Name "DEPTHONLY"
            Tags {"LightMode" = "DepthOnly"}
		    Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #pragma multi_compile _ DOTS_INSTANCING_ON

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_ALPHACLIP
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // AlphaMask and Dissolve
            #pragma shader_feature_local _COLOROVERLAY_ON
            #pragma shader_feature_local GEOM_TYPE_BRANCH_DETAIL

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_depthonly.hlsl"

            ENDHLSL
        }

        // DepthNormals
        Pass
        {
            Name "DEPTHNORMALS"
            Tags {"LightMode" = "DepthNormals"}
		    Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #pragma multi_compile _ DOTS_INSTANCING_ON

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_ALPHACLIP
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // AlphaMask and Dissolve
            #pragma shader_feature_local _COLOROVERLAY_ON
            #pragma shader_feature_local GEOM_TYPE_BRANCH_DETAIL

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_depthnormals.hlsl"

            ENDHLSL
        }

        // Universal2D
        Pass
        {
            Name "UNIVERSAL2D"
            Tags {"LightMode" = "Universal2D"}

            Stencil
            {
                Ref [_StencilRef]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
                Comp [_StencilComp]
                Pass [_StencilPass]
                Fail [_StencilFail]
                ZFail [_StencilZFail]
            }
            Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            ColorMask [_ColorMask]
            Offset [_OffsetFactor], [_OffsetUnits]
            BlendOp [_BlendOp], [_BlendOpAlpha]
            Blend [_SrcBlend] [_DstBlend], [_SrcBlendAlpha] [_DstBlendAlpha]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_universal2d.hlsl"
            ENDHLSL
        }

        // Meta
        Pass
        {
            Name "META"
            Tags {"LightMode" = "Meta"}
            Cull Off

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag

            // Tone correction and emission
            #pragma shader_feature_local EFFECT_HUE_VARIATION
            #pragma shader_feature_local _EMISSION
            #pragma shader_feature_local GEOM_TYPE_BRANCH
            #pragma shader_feature_local _SUNDISK_SIMPLE

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_meta.hlsl"
            ENDHLSL
        }
    }

    //----------------------------------------------------------------------------------------------------------------------
    // Universal Render Pipeline
    SubShader
    {
        Tags {"RenderType" = "Transparent" "Queue" = "Transparent"}
        HLSLINCLUDE
            #pragma only_renderers gles gles3 glcore d3d11
        ENDHLSL

        // Forward
        Pass
        {
            Name "FORWARD"
            Tags {"LightMode" = "UniversalForward"}

            Stencil
            {
                Ref [_StencilRef]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
                Comp [_StencilComp]
                Pass [_StencilPass]
                Fail [_StencilFail]
                ZFail [_StencilZFail]
            }
            Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            ColorMask [_ColorMask]
            Offset [_OffsetFactor], [_OffsetUnits]
            BlendOp [_BlendOp], [_BlendOpAlpha]
            Blend [_SrcBlend] [_DstBlend], [_SrcBlendAlpha] [_DstBlendAlpha]
            AlphaToMask [_AlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile _ _LIGHT_LAYERS
            #pragma multi_compile _ _CLUSTERED_RENDERING
            #pragma multi_compile_fragment _ _LIGHT_COOKIES
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
            #pragma multi_compile_fragment _ LIGHTMAP_SHADOW_MIXING
            #pragma multi_compile_fragment _ SHADOWS_SHADOWMASK
            #pragma multi_compile_fragment _ LIGHTMAP_ON
            #pragma multi_compile_fragment _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile_vertex _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer

            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
            #pragma multi_compile_fragment _ _SHADOWS_SOFT

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_ALPHACLIP
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // AlphaMask and Dissolve
            #pragma shader_feature_local _COLOROVERLAY_ON
            #pragma shader_feature_local GEOM_TYPE_BRANCH_DETAIL

            // Main
            #pragma shader_feature_local EFFECT_HUE_VARIATION
            #pragma shader_feature_local _COLORADDSUBDIFF_ON
            #pragma shader_feature_local _COLORCOLOR_ON
            #pragma shader_feature_local _SUNDISK_NONE
            #pragma shader_feature_local GEOM_TYPE_FROND
            #pragma shader_feature_local _REQUIRE_UV2
            #pragma shader_feature_local ANTI_FLICKER
            #pragma shader_feature_local _EMISSION
            #pragma shader_feature_local GEOM_TYPE_BRANCH
            #pragma shader_feature_local _SUNDISK_SIMPLE
            #pragma shader_feature_local _NORMALMAP
            #pragma shader_feature_local EFFECT_BUMP
            #pragma shader_feature_local SOURCE_GBUFFER
            #pragma shader_feature_local _GLOSSYREFLECTIONS_OFF
            #pragma shader_feature_local _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            #pragma shader_feature_local _SPECULARHIGHLIGHTS_OFF
            #pragma shader_feature_local GEOM_TYPE_MESH
            #pragma shader_feature_local _METALLICGLOSSMAP
            #pragma shader_feature_local GEOM_TYPE_LEAF
            #pragma shader_feature_local _SPECGLOSSMAP
            #pragma shader_feature_local _PARALLAXMAP
            #pragma shader_feature_local PIXELSNAP_ON
            #pragma shader_feature_local _FADING_ON
            #pragma shader_feature_local _MAPPING_6_FRAMES_LAYOUT
            #pragma shader_feature_local _SUNDISK_HIGH_QUALITY

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        // Fur
        Pass
        {
            Name "FORWARD_FUR"
            Tags {"LightMode" = "UniversalForward"}

            Stencil
            {
                Ref [_FurStencilRef]
                ReadMask [_FurStencilReadMask]
                WriteMask [_FurStencilWriteMask]
                Comp [_FurStencilComp]
                Pass [_FurStencilPass]
                Fail [_FurStencilFail]
                ZFail [_FurStencilZFail]
            }
            Cull [_FurCull]
            ZClip [_FurZClip]
            ZWrite [_FurZWrite]
            ZTest [_FurZTest]
            ColorMask [_FurColorMask]
            Offset [_FurOffsetFactor], [_FurOffsetUnits]
            BlendOp [_FurBlendOp], [_FurBlendOpAlpha]
            Blend [_FurSrcBlend] [_FurDstBlend], [_FurSrcBlendAlpha] [_FurDstBlendAlpha]
            AlphaToMask [_FurAlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma geometry geom
            #pragma fragment frag
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile _ _LIGHT_LAYERS
            #pragma multi_compile _ _CLUSTERED_RENDERING
            #pragma multi_compile_fragment _ _LIGHT_COOKIES
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
            #pragma multi_compile_fragment _ LIGHTMAP_SHADOW_MIXING
            #pragma multi_compile_fragment _ SHADOWS_SHADOWMASK
            #pragma multi_compile_fragment _ LIGHTMAP_ON
            #pragma multi_compile_fragment _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile_vertex _ FOG_LINEAR FOG_EXP FOG_EXP2
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // Main
            #pragma shader_feature_local _REQUIRE_UV2
            #pragma shader_feature_local _FADING_ON

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_forward_fur.hlsl"

            ENDHLSL
        }

        // ShadowCaster
        Pass
        {
            Name "SHADOW_CASTER"
            Tags {"LightMode" = "ShadowCaster"}
		    Cull [_Cull]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW
            #pragma multi_compile_instancing

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_ALPHACLIP
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // AlphaMask and Dissolve
            #pragma shader_feature_local _COLOROVERLAY_ON
            #pragma shader_feature_local GEOM_TYPE_BRANCH_DETAIL

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_shadowcaster.hlsl"

            ENDHLSL
        }

        // DepthOnly
        Pass
        {
            Name "DEPTHONLY"
            Tags {"LightMode" = "DepthOnly"}
		    Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_ALPHACLIP
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // AlphaMask and Dissolve
            #pragma shader_feature_local _COLOROVERLAY_ON
            #pragma shader_feature_local GEOM_TYPE_BRANCH_DETAIL

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_depthonly.hlsl"

            ENDHLSL
        }

        // DepthNormals
        Pass
        {
            Name "DEPTHNORMALS"
            Tags {"LightMode" = "DepthNormals"}
		    Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_ALPHACLIP
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // AlphaMask and Dissolve
            #pragma shader_feature_local _COLOROVERLAY_ON
            #pragma shader_feature_local GEOM_TYPE_BRANCH_DETAIL

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_depthnormals.hlsl"

            ENDHLSL
        }

        // Universal2D
        Pass
        {
            Name "UNIVERSAL2D"
            Tags {"LightMode" = "Universal2D"}

            Stencil
            {
                Ref [_StencilRef]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
                Comp [_StencilComp]
                Pass [_StencilPass]
                Fail [_StencilFail]
                ZFail [_StencilZFail]
            }
            Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            ColorMask [_ColorMask]
            Offset [_OffsetFactor], [_OffsetUnits]
            BlendOp [_BlendOp], [_BlendOpAlpha]
            Blend [_SrcBlend] [_DstBlend], [_SrcBlendAlpha] [_DstBlendAlpha]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_universal2d.hlsl"
            ENDHLSL
        }

        // Meta
        Pass
        {
            Name "META"
            Tags {"LightMode" = "Meta"}
            Cull Off

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag

            // Tone correction and emission
            #pragma shader_feature_local EFFECT_HUE_VARIATION
            #pragma shader_feature_local _EMISSION
            #pragma shader_feature_local GEOM_TYPE_BRANCH
            #pragma shader_feature_local _SUNDISK_SIMPLE

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_urp.hlsl"
            #include "Includes/lil_pass_meta.hlsl"
            ENDHLSL
        }
    }
    Fallback "Universal Render Pipeline/Unlit"
*/
// URP End

//----------------------------------------------------------------------------------------------------------------------
// HDRP Start
/*
    HLSLINCLUDE
        #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
    ENDHLSL
    SubShader
    {
        Tags {"RenderType" = "HDLitShader" "Queue" = "Transparent"}

        // Forward
        Pass
        {
            Name "FORWARD"
            Tags {"LightMode" = "ForwardOnly"}

            Stencil
            {
                WriteMask 6
                Ref 0
                Comp Always
                Pass Replace
            }
            Cull [_Cull]
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            ColorMask [_ColorMask]
            Offset [_OffsetFactor], [_OffsetUnits]
            BlendOp [_BlendOp], [_BlendOpAlpha]
            Blend [_SrcBlend] [_DstBlend], [_SrcBlendAlpha] [_DstBlendAlpha]
            AlphaToMask [_AlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ DOTS_INSTANCING_ON
            #pragma multi_compile_fragment _ LIGHTMAP_ON
            #pragma multi_compile_fragment _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fragment _ SHADOWS_SHADOWMASK

            #pragma multi_compile_fragment SCREEN_SPACE_SHADOWS_OFF SCREEN_SPACE_SHADOWS_ON
            #pragma multi_compile_fragment SHADOW_LOW SHADOW_MEDIUM SHADOW_HIGH

            #define SHADERPASS SHADERPASS_FORWARD

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_ALPHACLIP
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // AlphaMask and Dissolve
            #pragma shader_feature_local _COLOROVERLAY_ON
            #pragma shader_feature_local GEOM_TYPE_BRANCH_DETAIL

            // Main
            #pragma shader_feature_local EFFECT_HUE_VARIATION
            #pragma shader_feature_local _COLORADDSUBDIFF_ON
            #pragma shader_feature_local _COLORCOLOR_ON
            #pragma shader_feature_local _SUNDISK_NONE
            #pragma shader_feature_local GEOM_TYPE_FROND
            #pragma shader_feature_local _REQUIRE_UV2
            #pragma shader_feature_local ANTI_FLICKER
            #pragma shader_feature_local _EMISSION
            #pragma shader_feature_local GEOM_TYPE_BRANCH
            #pragma shader_feature_local _SUNDISK_SIMPLE
            #pragma shader_feature_local _NORMALMAP
            #pragma shader_feature_local EFFECT_BUMP
            #pragma shader_feature_local SOURCE_GBUFFER
            #pragma shader_feature_local _GLOSSYREFLECTIONS_OFF
            #pragma shader_feature_local _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            #pragma shader_feature_local _SPECULARHIGHLIGHTS_OFF
            #pragma shader_feature_local GEOM_TYPE_MESH
            #pragma shader_feature_local _METALLICGLOSSMAP
            #pragma shader_feature_local GEOM_TYPE_LEAF
            #pragma shader_feature_local _SPECGLOSSMAP
            #pragma shader_feature_local _PARALLAXMAP
            #pragma shader_feature_local PIXELSNAP_ON
            #pragma shader_feature_local _FADING_ON
            #pragma shader_feature_local _MAPPING_6_FRAMES_LAYOUT
            #pragma shader_feature_local _SUNDISK_HIGH_QUALITY

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_hdrp.hlsl"
            #include "Includes/lil_pass_forward.hlsl"

            ENDHLSL
        }

        // Fur
        Pass
        {
            Name "FORWARD_FUR"
            Tags {"LightMode" = "SRPDefaultUnlit"}

            Stencil
            {
                WriteMask 6
                Ref 0
                Comp Always
                Pass Replace
            }
            Cull [_FurCull]
            ZClip [_FurZClip]
            ZWrite [_FurZWrite]
            ZTest [_FurZTest]
            ColorMask [_FurColorMask]
            Offset [_FurOffsetFactor], [_FurOffsetUnits]
            BlendOp [_FurBlendOp], [_FurBlendOpAlpha]
            Blend [_FurSrcBlend] [_FurDstBlend], [_FurSrcBlendAlpha] [_FurDstBlendAlpha]
            AlphaToMask [_FurAlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma geometry geom
            #pragma fragment frag
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ DOTS_INSTANCING_ON
            #pragma multi_compile_fragment _ LIGHTMAP_ON
            #pragma multi_compile_fragment _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fragment _ SHADOWS_SHADOWMASK

            #define SHADERPASS SHADERPASS_FORWARD

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // Main
            #pragma shader_feature_local _REQUIRE_UV2
            #pragma shader_feature_local _FADING_ON

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_hdrp.hlsl"
            #include "Includes/lil_pass_forward_fur.hlsl"

            ENDHLSL
        }

        // ShadowCaster
        Pass
        {
            Name "SHADOW_CASTER"
            Tags {"LightMode" = "ShadowCaster"}

            Cull[_Cull]
            ZClip [_ZClip]
            ZWrite On
            ZTest LEqual

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma geometry geom
            #pragma fragment frag
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ DOTS_INSTANCING_ON

            #define SHADERPASS SHADERPASS_SHADOWS

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_ALPHACLIP
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // AlphaMask and Dissolve
            #pragma shader_feature_local _COLOROVERLAY_ON
            #pragma shader_feature_local GEOM_TYPE_BRANCH_DETAIL

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #define LIL_ONEPASS_FUR
            #include "Includes/lil_pipeline_hdrp.hlsl"
            #include "Includes/lil_pass_depthonly.hlsl"

            ENDHLSL
        }

        // DepthOnly
        Pass
        {
            Name "DEPTHONLY"
            Tags {"LightMode" = "DepthForwardOnly"}

            Stencil
            {
                WriteMask 8
                Ref 0
                Comp Always
                Pass Replace
            }
            Cull Back
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            Offset [_OffsetFactor], [_OffsetUnits]
            AlphaToMask [_AlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma geometry geom
            #pragma fragment frag
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ DOTS_INSTANCING_ON
            #pragma multi_compile _ WRITE_NORMAL_BUFFER
            #pragma multi_compile _ WRITE_MSAA_DEPTH

            #define SHADERPASS SHADERPASS_DEPTH_ONLY

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_ALPHACLIP
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // AlphaMask and Dissolve
            #pragma shader_feature_local _COLOROVERLAY_ON
            #pragma shader_feature_local GEOM_TYPE_BRANCH_DETAIL

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #define LIL_ONEPASS_FUR
            #include "Includes/lil_pipeline_hdrp.hlsl"
            #include "Includes/lil_pass_depthonly.hlsl"

            ENDHLSL
        }

        // MotionVectors
        Pass
        {
            Name "MOTIONVECTORS"
            Tags {"LightMode" = "MotionVectors"}

            Stencil
            {
                WriteMask 40
                Ref 32
                Comp Always
                Pass Replace
            }
            Cull Back
            ZClip [_ZClip]
            ZWrite [_ZWrite]
            ZTest [_ZTest]
            Offset [_OffsetFactor], [_OffsetUnits]
            AlphaToMask [_AlphaToMask]

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma geometry geom
            #pragma fragment frag
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ DOTS_INSTANCING_ON
            #pragma multi_compile _ WRITE_NORMAL_BUFFER
            #pragma multi_compile _ WRITE_MSAA_DEPTH

            #define SHADERPASS SHADERPASS_MOTION_VECTORS

            // Transparent mode
            #pragma shader_feature_local UNITY_UI_ALPHACLIP
            #pragma shader_feature_local UNITY_UI_CLIP_RECT

            // AlphaMask and Dissolve
            #pragma shader_feature_local _COLOROVERLAY_ON
            #pragma shader_feature_local GEOM_TYPE_BRANCH_DETAIL

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #define LIL_ONEPASS_FUR
            #include "Includes/lil_pipeline_hdrp.hlsl"
            #include "Includes/lil_pass_motionvectors.hlsl"

            ENDHLSL
        }

        // Meta
        Pass
        {
            Name "META"
            Tags {"LightMode" = "META"}
            Cull Off

            HLSLPROGRAM

            //----------------------------------------------------------------------------------------------------------------------
            // Build Option
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ DOTS_INSTANCING_ON

            #define SHADERPASS SHADERPASS_LIGHT_TRANSPORT

            // Tone correction and emission
            #pragma shader_feature_local EFFECT_HUE_VARIATION
            #pragma shader_feature_local _EMISSION
            #pragma shader_feature_local GEOM_TYPE_BRANCH
            #pragma shader_feature_local _SUNDISK_SIMPLE

            // Replace keywords
            #include "Includes/lil_replace_keywords.hlsl"

            //----------------------------------------------------------------------------------------------------------------------
            // Pass
            #include "Includes/lil_pipeline_hdrp.hlsl"
            #include "Includes/lil_pass_meta.hlsl"
            ENDHLSL
        }
    }
    Fallback "HDRP/Unlit"
*/
// HDRP End

    CustomEditor "lilToon.lilToonInspector"
}