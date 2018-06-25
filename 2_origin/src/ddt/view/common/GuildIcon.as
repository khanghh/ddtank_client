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
      
      public function setInfo(level:int, cid:int, repute:int) : void
      {
         _cid = cid;
         _level = level;
         _repute = repute;
         var st:int = PlayerManager.Instance.Self.ConsortiaID > 0?cid == PlayerManager.Instance.Self.ConsortiaID?1:3:2;
         _icon.setFrame(st == 3?2:1);
         _tipData.Level = level;
         _tipData.State = st;
         _tipData.Repute = repute;
      }
      
      public function set showTip(value:Boolean) : void
      {
         if(value)
         {
            ShowTipManager.Instance.addTip(this);
         }
         else
         {
            ShowTipManager.Instance.removeTip(this);
         }
      }
      
      public function set size(value:String) : void
      {
         if(value == "big")
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
         var st:int = PlayerManager.Instance.Self.ConsortiaID > 0?_cid == PlayerManager.Instance.Self.ConsortiaID?1:3:2;
         _icon.setFrame(st == 3?2:1);
         _tipData.Level = _level;
         _tipData.State = st;
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
      
      public function set tipStyle(value:String) : void
      {
         _tipStyle = value;
      }
      
      public function set tipData(value:Object) : void
      {
         _tipData = value as GuildIconTipInfo;
      }
      
      public function set tipDirctions(value:String) : void
      {
         _tipDirctions = value;
      }
      
      public function set tipGapV(value:int) : void
      {
         _tipGapV = value;
      }
      
      public function set tipGapH(value:int) : void
      {
         _tipGapH = value;
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
