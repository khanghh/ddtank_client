package gameStarling.view.buff
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.view.tips.PropTxtTipInfo;
   import gameCommon.model.FightBuffInfo;
   import gameCommon.view.buff.FightContainerBuff;
   import road7th.StarlingMain;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.text.TextField;
   
   public class BuffCell3D extends Sprite
   {
       
      
      private var _info:FightBuffInfo;
      
      private var _tipData:PropTxtTipInfo;
      
      private var _txt:TextField;
      
      private var _buffAnimation:BoneMovieStarling;
      
      private var _image:Image;
      
      public function BuffCell3D()
      {
         super();
         touchable = false;
         _tipData = new PropTxtTipInfo();
         _tipData.color = 15790320;
      }
      
      override public function dispose() : void
      {
         clearSelf();
         _tipData = null;
         super.dispose();
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function clearSelf() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
         StarlingObjectUtils.disposeObject(_txt);
         _txt = null;
         StarlingObjectUtils.disposeObject(_image);
         _image = null;
         StarlingObjectUtils.disposeObject(_buffAnimation);
         _buffAnimation = null;
         _info = null;
      }
      
      public function setInfo(param1:FightBuffInfo) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         clearSelf();
         _info = param1;
         _tipData.property = _info.buffName;
         _tipData.detail = _info.description;
         if(isContainerBuff(_info))
         {
            if(_info.type == 2)
            {
               _image = StarlingMain.instance.createImage("core_buff_payBuffAsset");
            }
            else if(_info.type == 3)
            {
               _image = StarlingMain.instance.createImage("game_buff_consortia");
            }
            else
            {
               _image = StarlingMain.instance.createImage("game_buff_card");
            }
         }
         else if(param1.type == 5)
         {
            _image = StarlingMain.instance.createImage("game_buff_pet" + param1.buffPic);
            _loc2_ = 32 / this.scaleX;
            var _loc4_:* = _loc2_;
            _image.height = _loc4_;
            _image.width = _loc4_;
         }
         else if(isActivityDunBuff(_info))
         {
            _buffAnimation = BoneMovieFactory.instance.creatBoneMovie("bone.game.buff" + _info.displayid);
         }
         else
         {
            _image = StarlingMain.instance.createImage("game_buff_" + _info.displayid);
         }
         if(_image)
         {
            addChild(_image);
         }
         if(_buffAnimation)
         {
            addChild(_buffAnimation);
         }
         if(_info.Count > 1)
         {
            _loc3_ = FilterFrameText.getStringWidthByTextField(_info.Count.toString(),15);
            _txt = new TextField(_loc3_,20,_info.Count.toString(),"Arial",14,6155281,true);
            addChild(_txt);
         }
         else
         {
            StarlingObjectUtils.disposeObject(_txt);
            _txt = null;
         }
      }
      
      public function get tipData() : Object
      {
         if(isContainerBuff(_info))
         {
            return FightContainerBuff(_info).tipData;
         }
         return _tipData;
      }
      
      private function isContainerBuff(param1:FightBuffInfo) : Boolean
      {
         return param1.type == 2 || param1.type == 3 || param1.type == 4;
      }
      
      private function isActivityDunBuff(param1:FightBuffInfo) : Boolean
      {
         return param1.displayid == 114 || param1.displayid == 115;
      }
      
      public function set tipData(param1:Object) : void
      {
      }
      
      public function get tipDirctions() : String
      {
         return "7,6,5,1,6,4";
      }
      
      public function set tipDirctions(param1:String) : void
      {
      }
      
      public function get tipGapH() : int
      {
         return 6;
      }
      
      public function set tipGapH(param1:int) : void
      {
      }
      
      public function get tipGapV() : int
      {
         return 6;
      }
      
      public function set tipGapV(param1:int) : void
      {
      }
      
      public function get tipStyle() : String
      {
         if(isContainerBuff(_info))
         {
            return "core.PayBuffTip";
         }
         return "core.FightBuffTip";
      }
      
      public function set tipStyle(param1:String) : void
      {
      }
   }
}
