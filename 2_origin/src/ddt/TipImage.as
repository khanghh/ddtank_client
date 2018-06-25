package ddt
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import ddt.utils.StaticFormula;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class TipImage extends Sprite implements Disposeable
   {
      
      public static const TRANSFER:int = 0;
      
      public static const EMBED:int = 1;
      
      public static const BEGIN_Y:int = 130;
      
      public static const SPACING:String = " ";
      
      public static const SPACINGII:String = " +";
      
      public static const SPACINGIII:String = " ";
      
      public static const Shield:int = 31;
       
      
      private var _timer:Timer;
      
      public var _successBit:Bitmap;
      
      public var _failBit:Bitmap;
      
      public var _fiveFailBit:Bitmap;
      
      private var _moveSprite:Sprite;
      
      public var isDisplayerTip:Boolean = true;
      
      private var _lastTipString:String = "";
      
      public function TipImage()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _moveSprite = new Sprite();
         addChild(_moveSprite);
         _timer = new Timer(7500,1);
         _timer.addEventListener("timerComplete",__timerComplete);
      }
      
      private function createTween(onComplete:Function = null, completeParam:Array = null) : void
      {
         MessageTipManager.getInstance().kill();
         TweenMax.killTweensOf(_moveSprite);
         TweenMax.from(_moveSprite,0.4,{
            "y":130,
            "alpha":0
         });
         TweenMax.to(_moveSprite,0.4,{
            "delay":1.4,
            "y":130 * -1,
            "alpha":0,
            "onComplete":(onComplete == null?removeTips:onComplete),
            "onCompleteParams":completeParam
         });
      }
      
      private function showPropertyChange(info:InventoryItemInfo) : String
      {
         var diff:Number = NaN;
         var str:String = "";
         var chatStr:String = "";
         if(EquipType.isArm(info))
         {
            diff = StaticFormula.getHertAddition(int(info.Property7),info.StrengthenLevel) - StaticFormula.getHertAddition(int(info.Property7),info.StrengthenLevel - 1);
            str = LanguageMgr.GetTranslation("store.storeTip.hurt"," "," +",diff);
            chatStr = LanguageMgr.GetTranslation("store.storeTip.chatHurt",diff);
         }
         else if(int(info.Property3) == 32)
         {
            diff = StaticFormula.getRecoverHPAddition(int(info.Property7),info.StrengthenLevel) - StaticFormula.getRecoverHPAddition(int(info.Property7),info.StrengthenLevel - 1);
            str = LanguageMgr.GetTranslation("store.storeTip.AddHP"," "," +",diff);
            chatStr = LanguageMgr.GetTranslation("store.storeTip.chatAddHP",diff);
         }
         else if(int(info.Property3) == 31)
         {
            diff = StaticFormula.getDefenseAddition(int(info.Property7),info.StrengthenLevel) - StaticFormula.getDefenseAddition(int(info.Property7),info.StrengthenLevel - 1);
            str = LanguageMgr.GetTranslation("store.storeTip.subHurt"," "," +",diff);
            chatStr = LanguageMgr.GetTranslation("store.storeTip.chatSubHurt",diff);
         }
         else if(EquipType.isEquip(info))
         {
            diff = StaticFormula.getDefenseAddition(int(info.Property7),info.StrengthenLevel) - StaticFormula.getDefenseAddition(int(info.Property7),info.StrengthenLevel - 1);
            str = LanguageMgr.GetTranslation("store.storeTip.Armor"," "," +",diff);
            chatStr = LanguageMgr.GetTranslation("store.storeTip.chatArmor",diff);
         }
         _lastTipString = _lastTipString + str;
         return chatStr;
      }
      
      private function showHoleTip(info:InventoryItemInfo) : String
      {
         var arr:* = null;
         var number:int = 0;
         var chatStr:String = "";
         var str:String = LanguageMgr.GetTranslation("store.storeTip.openHole");
         if(info.CategoryID == 1 || info.CategoryID == 5)
         {
            if(info.StrengthenLevel == 3 || info.StrengthenLevel == 9 || info.StrengthenLevel == 12)
            {
               str = str + (" " + LanguageMgr.GetTranslation("store.storeTip.weaponOpenProperty"));
            }
            if(info.StrengthenLevel == 6)
            {
               str = str + (" " + LanguageMgr.GetTranslation("store.storeTip.clothOpenDefense"));
            }
         }
         else if(info.CategoryID == 7)
         {
            if(info.StrengthenLevel == 6 || info.StrengthenLevel == 9 || info.StrengthenLevel == 12)
            {
               str = str + (" " + LanguageMgr.GetTranslation("store.storeTip.weaponOpenProperty"));
            }
            if(info.StrengthenLevel == 3)
            {
               str = str + (" " + LanguageMgr.GetTranslation("store.storeTip.weaponOpenAttack"));
            }
         }
         if((info.CategoryID == 1 || info.CategoryID == 5 || info.CategoryID == 7) && (info.StrengthenLevel == 3 || info.StrengthenLevel == 6 || info.StrengthenLevel == 9 || info.StrengthenLevel == 12))
         {
            arr = info.Hole.split("|");
            number = info.StrengthenLevel / 3;
            if(arr[number - 1].split(",")[1] > 0 && info["Hole" + number] >= 0)
            {
               _lastTipString = _lastTipString + ("\n" + str);
               return chatStr;
            }
         }
         return null;
      }
      
      private function showOpenHoleTip(info:InventoryItemInfo) : String
      {
         var str:String = LanguageMgr.GetTranslation("store.storeTip.openHole");
         str = str + (" " + LanguageMgr.GetTranslation("store.storeTip.weaponOpenProperty"));
         return str;
      }
      
      public function showSuccess() : void
      {
         removeTips();
         if(isDisplayerTip)
         {
            if(!_moveSprite)
            {
               _moveSprite = new Sprite();
               addChild(_moveSprite);
            }
            _moveSprite.addChild(_successBit);
            createTween();
         }
         SoundManager.instance.pauseMusic();
         SoundManager.instance.play("063",false,false);
         _timer.start();
      }
      
      public function showStrengthSuccess(info:InventoryItemInfo, isShowHoleTip:Boolean) : void
      {
         var propertyString:* = null;
         var holeString:* = null;
         _lastTipString = "";
         removeTips();
         if(isDisplayerTip)
         {
            if(!_moveSprite)
            {
               _moveSprite = new Sprite();
               addChild(_moveSprite);
            }
            _moveSprite.addChild(_successBit);
            propertyString = showPropertyChange(info);
            holeString = !!isShowHoleTip?showHoleTip(info):null;
            if(holeString)
            {
               propertyString = propertyString.replace("!",",");
               propertyString = propertyString + holeString;
            }
            createTween(strengthTweenComplete,[propertyString]);
            ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("store.Strength.Succes.ChatSay") + propertyString);
         }
         SoundManager.instance.pauseMusic();
         SoundManager.instance.play("063",false,false);
         _timer.start();
      }
      
      private function strengthTweenComplete(content:String) : void
      {
         if(content)
         {
            MessageTipManager.getInstance().show(content);
         }
         removeTips();
      }
      
      public function showEmbedSuccess(info:InventoryItemInfo) : void
      {
         var openHoleString:* = null;
         _lastTipString = "";
         if(isDisplayerTip)
         {
            if(!_moveSprite)
            {
               _moveSprite = new Sprite();
               addChild(_moveSprite);
            }
            _moveSprite.addChild(_successBit);
            openHoleString = showOpenHoleTip(info);
            createTween(embedTweenComplete);
            _lastTipString = openHoleString;
            ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("store.Strength.Succes.ChatSay") + _lastTipString);
         }
         SoundManager.instance.pauseMusic();
         SoundManager.instance.play("063",false,false);
         _timer.start();
      }
      
      private function embedTweenComplete() : void
      {
         MessageTipManager.getInstance().show(_lastTipString);
         removeTips();
      }
      
      public function showFail() : void
      {
         removeTips();
         if(isDisplayerTip)
         {
            if(!_moveSprite)
            {
               _moveSprite = new Sprite();
               addChild(_moveSprite);
            }
            _moveSprite.addChild(_failBit);
            createTween();
         }
         SoundManager.instance.pauseMusic();
         SoundManager.instance.play("064",false,false);
         _timer.start();
      }
      
      public function showFiveFail() : void
      {
         removeTips();
         if(isDisplayerTip)
         {
            if(!_moveSprite)
            {
               _moveSprite = new Sprite();
               addChild(_moveSprite);
            }
            _moveSprite.addChild(_failBit);
            createTween();
         }
         SoundManager.instance.pauseMusic();
         SoundManager.instance.play("064",false,false);
         _timer.start();
      }
      
      private function __timerComplete(evt:TimerEvent) : void
      {
         _timer.reset();
         SoundManager.instance.resumeMusic();
         SoundManager.instance.stop("063");
         SoundManager.instance.stop("064");
      }
      
      private function removeTips() : void
      {
         if(_moveSprite && _moveSprite.parent)
         {
            while(_moveSprite.numChildren)
            {
               _moveSprite.removeChildAt(0);
            }
            TweenMax.killTweensOf(_moveSprite);
            _moveSprite.parent.removeChild(_moveSprite);
            _moveSprite = null;
         }
      }
      
      public function dispose() : void
      {
         _timer.removeEventListener("timerComplete",__timerComplete);
         _timer.stop();
         _timer = null;
         TweenMax.killTweensOf(_moveSprite);
         SoundManager.instance.resumeMusic();
         SoundManager.instance.stop("063");
         SoundManager.instance.stop("064");
         removeTips();
         if(_successBit)
         {
            ObjectUtils.disposeObject(_successBit);
         }
         _successBit = null;
         if(_failBit)
         {
            ObjectUtils.disposeObject(_failBit);
         }
         _failBit = null;
         if(_fiveFailBit)
         {
            ObjectUtils.disposeObject(_fiveFailBit);
         }
         _fiveFailBit = null;
         if(_moveSprite)
         {
            ObjectUtils.disposeObject(_moveSprite);
         }
         _moveSprite = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
