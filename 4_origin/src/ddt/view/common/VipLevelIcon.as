package ddt.view.common
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.BasePlayer;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import vip.VipController;
   
   public class VipLevelIcon extends Sprite implements ITipedDisplay, Disposeable
   {
      
      public static const SIZE_BIG:int = 0;
      
      public static const SIZE_SMALL:int = 1;
      
      private static const LEVEL_ICON_CLASSPATH:String = "asset.vipIcon.vipLevel_";
       
      
      private var _seniorIcon:ScaleFrameImage;
      
      private var _level:int = 1;
      
      private var _type:int = 0;
      
      private var _isVip:Boolean = false;
      
      private var _vipExp:int = 0;
      
      private var _tipDirctions:String;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      private var _tipStyle:String;
      
      private var _tipData:String;
      
      private var _size:int;
      
      public function VipLevelIcon()
      {
         super();
         _tipStyle = "ddt.view.tips.OneLineTip";
         _tipGapV = 10;
         _tipGapH = 10;
         _tipDirctions = "7,4,6,5";
         _size = 1;
         _seniorIcon = ComponentFactory.Instance.creatComponentByStylename("core.SeniorVipLevelIcon");
         ShowTipManager.Instance.addTip(this);
      }
      
      public function setInfo(param1:BasePlayer, param2:Boolean = true, param3:Boolean = false) : void
      {
         var _loc4_:int = 0;
         _level = param1.VIPLevel;
         _isVip = param1.IsVIP;
         _vipExp = param1.VIPExp;
         if(param1.ID == PlayerManager.Instance.Self.ID)
         {
            if(param2)
            {
               buttonMode = !param3;
               if(_isVip)
               {
                  if(param1.VIPLevel < 15)
                  {
                     _loc4_ = ServerConfigManager.instance.VIPExpNeededForEachLv[_level] - param1.VIPExp;
                     _tipData = LanguageMgr.GetTranslation("ddt.vip.vipIcon.upGradDays",_loc4_,_level + 1);
                  }
                  else
                  {
                     _tipData = LanguageMgr.GetTranslation("ddt.vip.vipIcon.upGradFull");
                  }
               }
               else if(param1.VIPExp > 0)
               {
                  _tipData = LanguageMgr.GetTranslation("ddt.vip.vipView.expiredTrue");
               }
               else
               {
                  _tipData = LanguageMgr.GetTranslation("ddt.vip.vipFrame.youarenovip");
               }
            }
            else
            {
               mouseEnabled = false;
               mouseChildren = false;
            }
            if(!PlayerManager.Instance.Self.IsVIP && PlayerManager.Instance.Self.VIPExp == 0)
            {
               _level = 0;
            }
            if(!param3)
            {
               addEventListener("click",__showVipFrame);
            }
         }
         else
         {
            removeEventListener("click",__showVipFrame);
            buttonMode = false;
            if(param2)
            {
               _tipData = LanguageMgr.GetTranslation("ddt.vip.vipIcon.otherVipTip",param1.VIPLevel);
            }
            else
            {
               mouseEnabled = false;
               mouseChildren = false;
            }
         }
         _type = param1.typeVIP;
         updateIcon();
      }
      
      private function __showVipFrame(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         VipController.instance.show();
      }
      
      private function updateIcon() : void
      {
         DisplayUtils.removeDisplay(_seniorIcon);
         if(_size == 1)
         {
            if(_isVip || _vipExp > 0)
            {
               _seniorIcon.setFrame(_level + 17);
               addChild(_seniorIcon);
            }
            else
            {
               _seniorIcon.setFrame(17);
               addChild(_seniorIcon);
            }
         }
         else if(_size == 0)
         {
            if(_isVip || _vipExp > 0)
            {
               _seniorIcon.setFrame(_level + 1);
               addChild(_seniorIcon);
            }
            else
            {
               _seniorIcon.setFrame(1);
               addChild(_seniorIcon);
            }
         }
      }
      
      public function setSize(param1:int) : void
      {
         _size = param1;
         updateIcon();
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirctions;
      }
      
      public function get tipGapV() : int
      {
         return 0;
      }
      
      public function get tipGapH() : int
      {
         return 0;
      }
      
      public function set tipStyle(param1:String) : void
      {
         _tipStyle = param1;
      }
      
      public function set tipData(param1:Object) : void
      {
         _tipData = param1 as String;
      }
      
      public function set tipDirctions(param1:String) : void
      {
      }
      
      public function set tipGapV(param1:int) : void
      {
      }
      
      public function set tipGapH(param1:int) : void
      {
      }
      
      public function get tipWidth() : int
      {
         return 0;
      }
      
      public function set tipWidth(param1:int) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return null;
      }
      
      public function dispose() : void
      {
         ShowTipManager.Instance.removeTip(this);
         removeEventListener("click",__showVipFrame);
         ObjectUtils.disposeObject(_seniorIcon);
         _seniorIcon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
