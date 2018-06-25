package starling.scene.consortiaDomain.buildView
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieFastStarling;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import consortiaDomain.ConsortiaDomainManager;
   import consortiaDomain.EachBuildInfo;
   import consortion.ConsortionModelManager;
   import ddt.bagStore.BagStore;
   import ddt.manager.ConsortiaDutyManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import flash.display.BitmapData;
   import flash.events.Event;
   import road7th.DDTAssetManager;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.textures.Texture;
   import starlingui.core.components.PixelButton;
   import trainer.controller.WeakGuildManager;
   
   public class BuildView extends Sprite
   {
       
      
      public var buildId:int;
      
      private var _buildName:String;
      
      private var _state:int = -1;
      
      private var _build:PixelButton;
      
      private var _effArr:Array;
      
      private var _effSp:Sprite;
      
      private var _buildNameBg:Image;
      
      private var _buildNameImage:Image;
      
      private var _upStateIconSp:UpStateIconSp;
      
      private var _downStateIconSp:DownStateIconSp;
      
      private var _buildImageScale:Number;
      
      private var _upGradeBtn:Button;
      
      private var _openBtn:Button;
      
      private var _isShow:Boolean;
      
      public function BuildView(buildId:int, buildImageScale:Number)
      {
         super();
         this.buildId = buildId;
         _buildImageScale = buildImageScale;
         _buildName = ConsortiaDomainManager.BUILD_RES_NAME_ARR[buildId];
         var buildT:Texture = DDTAssetManager.instance.getTexture(_buildName);
         var buildBmd:BitmapData = DDTAssetManager.instance.nativeAsset.getBitmapData(_buildName);
         _build = new PixelButton(buildT,"",null,null,null,buildBmd);
         var _loc5_:* = _buildImageScale;
         _build.scaleY = _loc5_;
         _build.scaleX = _loc5_;
         _build.scaleWhenDown = 1;
         addChild(_build);
         _effSp = new Sprite();
         addChild(_effSp);
         _effArr = [];
         _buildNameBg = new Image(DDTAssetManager.instance.getTexture(_buildName + "TitleBg"));
         _buildNameBg.touchable = false;
         addChild(_buildNameBg);
         _buildNameImage = new Image(DDTAssetManager.instance.getTexture(_buildName + "Title1"));
         _buildNameImage.touchable = false;
         addChild(_buildNameImage);
         _upStateIconSp = new UpStateIconSp();
         _upStateIconSp.touchable = false;
         addChild(_upStateIconSp);
         _downStateIconSp = new DownStateIconSp(buildId);
         _downStateIconSp.touchable = false;
         addChild(_downStateIconSp);
         addEventListener("touch",onTouchBuild);
         ConsortiaDomainManager.instance.addEventListener("event_build_in_fight_state_change",onBuildStateChange);
         ConsortiaDomainManager.instance.addEventListener("event_get_consortia_info_res",onBuildStateChange);
         onBuildStateChange(null);
      }
      
      public function setBuildXY(x:int, y:int) : void
      {
         _build.x = x;
         _build.y = y;
      }
      
      public function createEff(effBoneStyle:String, x:int, y:int, scaleX:Number = 1, scaleY:Number = 1) : void
      {
         var eff:BoneMovieFastStarling = BoneMovieFactory.instance.creatBoneMovieFast(effBoneStyle);
         eff.touchable = false;
         eff.x = x;
         eff.y = y;
         eff.scaleX = scaleX;
         eff.scaleY = scaleY;
         _effSp.addChild(eff);
         _effArr.push(eff);
      }
      
      private function openBuildFrame() : void
      {
         var skillFrame:* = null;
         var _consortionBankFrame:* = null;
         if(buildId == 3)
         {
            ConsortionModelManager.Instance.alertShopFrame();
         }
         else if(buildId == 4)
         {
            if(WeakGuildManager.Instance.switchUserGuide && !PlayerManager.Instance.Self.IsWeakGuildFinish(950))
            {
               if(PlayerManager.Instance.Self.Grade < 5)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",5));
                  return;
               }
            }
            BagStore.instance.openStore("bag_store");
            ComponentSetting.SEND_USELOG_ID(2);
         }
         else if(buildId == 2)
         {
            skillFrame = ComponentFactory.Instance.creatComponentByStylename("consortionSkillFrame");
            LayerManager.Instance.addToLayer(skillFrame,3,true,1);
         }
         else if(buildId == 1)
         {
            _consortionBankFrame = ComponentFactory.Instance.creatComponentByStylename("consortionBankFrame");
            LayerManager.Instance.addToLayer(_consortionBankFrame,3,true,1);
         }
      }
      
      private function onBuildStateChange(evt:flash.events.Event) : void
      {
         var eachBuildInfo:EachBuildInfo = ConsortiaDomainManager.instance.model.allBuildInfo[buildId];
         if(eachBuildInfo)
         {
            state = eachBuildInfo.State;
         }
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(value:int) : void
      {
         if(_state != value)
         {
            if(value == 1)
            {
               this.touchable = true;
            }
            else if(value == 2)
            {
               this.touchable = true;
            }
            else if(value == 3)
            {
               this.touchable = true;
            }
            else if(value == 4)
            {
               this.touchable = true;
            }
            else if(value == 5)
            {
               this.touchable = false;
            }
            else if(value == 6)
            {
               this.touchable = false;
            }
            _state = value;
            updateBuildNameImage();
            _upStateIconSp.x = _buildNameImage.x + _buildNameImage.width + 19;
            _upStateIconSp.y = _buildNameImage.y + 15;
            _downStateIconSp.x = -95;
            if(buildId == 5)
            {
               _downStateIconSp.y = 185;
            }
            else
            {
               _downStateIconSp.y = 85;
            }
         }
         _upStateIconSp.state = value;
         _downStateIconSp.state = value;
      }
      
      private function updateBuildNameImage() : void
      {
         var buildNameT:* = null;
         _buildNameImage.color = 16777215;
         if(_state == 1 || _state == 2)
         {
            buildNameT = DDTAssetManager.instance.getTexture(_buildName + "Title1");
         }
         else if(_state == 5 || _state == 6)
         {
            buildNameT = DDTAssetManager.instance.getTexture(_buildName + "Title2");
         }
         else if(_state == 3 || _state == 4)
         {
            buildNameT = DDTAssetManager.instance.getTexture(_buildName + "Title1");
            _buildNameImage.color = 13421772;
         }
         if(buildId == 5)
         {
            _buildNameBg.x = -99;
            _buildNameBg.y = -105;
            _buildNameImage.y = -77;
         }
         else if(buildId == 4)
         {
            _buildNameBg.x = -112;
            _buildNameBg.y = -131;
            _buildNameImage.y = -104;
         }
         else if(buildId == 1)
         {
            _buildNameBg.x = -112;
            _buildNameBg.y = -64;
            _buildNameImage.y = -38;
         }
         else if(buildId == 3)
         {
            _buildNameBg.x = -126;
            _buildNameBg.y = -137;
            _buildNameImage.y = -113;
         }
         else if(buildId == 2)
         {
            _buildNameBg.x = -112;
            _buildNameBg.y = -160;
            _buildNameImage.y = -136;
         }
         _buildNameImage.x = -buildNameT.width * 0.5 - 11;
         _buildNameImage.texture = buildNameT;
      }
      
      private function onTouchBuild(evt:TouchEvent) : void
      {
         var touch:* = null;
         if(LayerManager.Instance.backGroundInParent)
         {
            showBtns(false);
            return;
         }
         if(_state == 1 || _state == 2)
         {
            touch = evt.getTouch(this);
            if(touch == null || touch.phase == "ended")
            {
               showBtns(false);
            }
            else if(touch.phase == "began" || touch.phase == "hover" || touch.phase == "moved")
            {
               showBtns(true);
            }
         }
      }
      
      private function showBtns(isShow:Boolean) : void
      {
         var right:int = 0;
         var isChangeMan:Boolean = false;
         if(_isShow != isShow)
         {
            _isShow = isShow;
            if(_isShow)
            {
               right = PlayerManager.Instance.Self.Right;
               isChangeMan = ConsortiaDutyManager.GetRight(right,512);
               if(isChangeMan)
               {
                  if(buildId == 5)
                  {
                     if(!_upGradeBtn)
                     {
                        _upGradeBtn = new Button(ConsortiaDomainManager.instance.getBuildViewUpGradeBtnTexture());
                        _upGradeBtn.scaleWhenDown = 0.96;
                        _upGradeBtn.addEventListener("triggered",onBtnClick);
                        addChild(_upGradeBtn);
                     }
                     _upGradeBtn.x = -_upGradeBtn.width * 0.5;
                     _upGradeBtn.y = -_build.height * 0.6 + 325;
                     _upGradeBtn.visible = true;
                  }
                  else
                  {
                     if(!_upGradeBtn)
                     {
                        _upGradeBtn = new Button(ConsortiaDomainManager.instance.getBuildViewUpGradeBtnTexture());
                        _upGradeBtn.scaleWhenDown = 0.96;
                        _upGradeBtn.addEventListener("triggered",onBtnClick);
                        addChild(_upGradeBtn);
                     }
                     _upGradeBtn.x = -_upGradeBtn.width - 10;
                     _upGradeBtn.y = -_build.height * 0.6 + 85;
                     _upGradeBtn.visible = true;
                     if(!_openBtn)
                     {
                        _openBtn = new Button(ConsortiaDomainManager.instance.getBuildViewOpenBtnTexture());
                        _openBtn.scaleWhenDown = 0.96;
                        _openBtn.addEventListener("triggered",onBtnClick);
                        addChild(_openBtn);
                     }
                     _openBtn.x = 10;
                     _openBtn.y = -_build.height * 0.6 + 85;
                     _openBtn.visible = true;
                  }
               }
               else if(buildId != 5)
               {
                  if(!_openBtn)
                  {
                     _openBtn = new Button(ConsortiaDomainManager.instance.getBuildViewOpenBtnTexture());
                     _openBtn.scaleWhenDown = 0.96;
                     _openBtn.addEventListener("triggered",onBtnClick);
                     addChild(_openBtn);
                  }
                  _openBtn.x = -_openBtn.width * 0.5;
                  _openBtn.y = -_build.height * 0.6 + 85;
                  _openBtn.visible = true;
               }
            }
            else
            {
               if(_upGradeBtn)
               {
                  _upGradeBtn.visible = false;
               }
               if(_openBtn)
               {
                  _openBtn.visible = false;
               }
            }
         }
      }
      
      private function onBtnClick(evt:starling.events.Event) : void
      {
         var upGradeFrame:* = null;
         if(evt.target == _upGradeBtn)
         {
            upGradeFrame = ComponentFactory.Instance.creat("consortionUpGradeFrame",[buildId]);
            LayerManager.Instance.addToLayer(upGradeFrame,3,true,1);
         }
         else if(evt.target == _openBtn)
         {
            openBuildFrame();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ConsortiaDomainManager.instance.removeEventListener("event_build_in_fight_state_change",onBuildStateChange);
         ConsortiaDomainManager.instance.removeEventListener("event_get_consortia_info_res",onBuildStateChange);
         _build = null;
         _effArr = null;
         _effSp = null;
         _buildNameBg = null;
         _buildNameImage = null;
         _upStateIconSp = null;
         _downStateIconSp = null;
         _upGradeBtn = null;
         _openBtn = null;
      }
   }
}
