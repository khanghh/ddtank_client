package ddt.view.common
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import ddt.manager.PlayerManager;
   import ddt.view.tips.GuildIconTipInfo;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class GuildIcon extends Sprite implements Disposeable, ITipedDisplay
   {
      
      public static const BIG:String = "big";
      
      public static const SMALL:String = "small";
       
      
      private var _icon:ScaleFrameImage;
      
      private var _tipDirctions:String;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      private var _tipStyle:String;
      
      private var _tipData:GuildIconTipInfo;
      
      private var _cid:int;
      
      private var _level:int;
      
      private var _repute:int;
      
      public function GuildIcon()
      {
         super();
         _icon = ComponentFactory.Instance.creatComponentByStylename("asset.core.guildIcon");
         addChild(_icon);
         _icon.setFrame(1);
         _tipStyle = "core.guildIconTip";
         _tipGapV = 5;
         _tipGapH = 5;
         _tipDirctions = "7,6";
         ShowTipManager.Instance.addTip(this);
         _tipData = new GuildIconTipInfo();
      }
      
      public function setInfo(param1:int, param2:int, param3:int) : void
      {
         _cid = param2;
         _level = param1;
         _repute = param3;
         var _loc4_:int = PlayerManager.Instance.Self.ConsortiaID > 0?param2 == PlayerManager.Instance.Self.ConsortiaID?1:3:2;
         _icon.setFrame(_loc4_ == 3?2:1);
         _tipData.Level = param1;
         _tipData.State = _loc4_;
         _tipData.Repute = param3;
      }
      
      public function set showTip(param1:Boolean) : void
      {
         if(param1)
         {
            ShowTipManager.Instance.addTip(this);
         }
         else
         {
            ShowTipManager.Instance.removeTip(this);
         }
      }
      
      public function set size(param1:String) : void
      {
         if(param1 == "big")
         {
            var _loc2_:* = 1;
            _icon.scaleY = _loc2_;
            _icon.scaleX = _loc2_;
         }
         else
         {
            _loc2_ = 0.8;
            _icon.scaleY = _loc2_;
            _icon.scaleX = _loc2_;
         }
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function get tipData() : Object
      {
         var _loc1_:int = PlayerManager.Instance.Self.ConsortiaID > 0?_cid == PlayerManager.Instance.Self.ConsortiaID?1:3:2;
         _icon.setFrame(_loc1_ == 3?2:1);
         _tipData.Level = _level;
         _tipData.State = _loc1_;
         _tipData.Repute = _repute;
         return _tipData;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirctions;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipStyle(param1:String) : void
      {
         _tipStyle = param1;
      }
      
      public function set tipData(param1:Object) : void
      {
         _tipData = param1 as GuildIconTipInfo;
      }
      
      public function set tipDirctions(param1:String) : void
      {
         _tipDirctions = param1;
      }
      
      public function set tipGapV(param1:int) : void
      {
         _tipGapV = param1;
      }
      
      public function set tipGapH(param1:int) : void
      {
         _tipGapH = param1;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         _icon.dispose();
         _icon = null;
         ShowTipManager.Instance.removeTip(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
