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
      
      private function createTween(param1:Function = null, param2:Array = null) : void
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
            "onComplete":(param1 == null?removeTips:param1),
            "onCompleteParams":param2
         });
      }
      
      private function showPropertyChange(param1:InventoryItemInfo) : String
      {
         var _loc3_:Number = NaN;
         var _loc2_:String = "";
         var _loc4_:String = "";
         if(EquipType.isArm(param1))
         {
            _loc3_ = StaticFormula.getHertAddition(int(param1.Property7),param1.StrengthenLevel) - StaticFormula.getHertAddition(int(param1.Property7),param1.StrengthenLevel - 1);
            _loc2_ = LanguageMgr.GetTranslation("store.storeTip.hurt"," "," +",_loc3_);
            _loc4_ = LanguageMgr.GetTranslation("store.storeTip.chatHurt",_loc3_);
         }
         else if(int(param1.Property3) == 32)
         {
            _loc3_ = StaticFormula.getRecoverHPAddition(int(param1.Property7),param1.StrengthenLevel) - StaticFormula.getRecoverHPAddition(int(param1.Property7),param1.StrengthenLevel - 1);
            _loc2_ = LanguageMgr.GetTranslation("store.storeTip.AddHP"," "," +",_loc3_);
            _loc4_ = LanguageMgr.GetTranslation("store.storeTip.chatAddHP",_loc3_);
         }
         else if(int(param1.Property3) == 31)
         {
            _loc3_ = StaticFormula.getDefenseAddition(int(param1.Property7),param1.StrengthenLevel) - StaticFormula.getDefenseAddition(int(param1.Property7),param1.StrengthenLevel - 1);
            _loc2_ = LanguageMgr.GetTranslation("store.storeTip.subHurt"," "," +",_loc3_);
            _loc4_ = LanguageMgr.GetTranslation("store.storeTip.chatSubHurt",_loc3_);
         }
         else if(EquipType.isEquip(param1))
         {
            _loc3_ = StaticFormula.getDefenseAddition(int(param1.Property7),param1.StrengthenLevel) - StaticFormula.getDefenseAddition(int(param1.Property7),param1.StrengthenLevel - 1);
            _loc2_ = LanguageMgr.GetTranslation("store.storeTip.Armor"," "," +",_loc3_);
            _loc4_ = LanguageMgr.GetTranslation("store.storeTip.chatArmor",_loc3_);
         }
         _lastTipString = _lastTipString + _loc2_;
         return _loc4_;
      }
      
      private function showHoleTip(param1:InventoryItemInfo) : String
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:String = "";
         var _loc2_:String = LanguageMgr.GetTranslation("store.storeTip.openHole");
         if(param1.CategoryID == 1 || param1.CategoryID == 5)
         {
            if(param1.StrengthenLevel == 3 || param1.StrengthenLevel == 9 || param1.StrengthenLevel == 12)
            {
               _loc2_ = _loc2_ + (" " + LanguageMgr.GetTranslation("store.storeTip.weaponOpenProperty"));
            }
            if(param1.StrengthenLevel == 6)
            {
               _loc2_ = _loc2_ + (" " + LanguageMgr.GetTranslation("store.storeTip.clothOpenDefense"));
            }
         }
         else if(param1.CategoryID == 7)
         {
            if(param1.StrengthenLevel == 6 || param1.StrengthenLevel == 9 || param1.StrengthenLevel == 12)
            {
               _loc2_ = _loc2_ + (" " + LanguageMgr.GetTranslation("store.storeTip.weaponOpenProperty"));
            }
            if(param1.StrengthenLevel == 3)
            {
               _loc2_ = _loc2_ + (" " + LanguageMgr.GetTranslation("store.storeTip.weaponOpenAttack"));
            }
         }
         if((param1.CategoryID == 1 || param1.CategoryID == 5 || param1.CategoryID == 7) && (param1.StrengthenLevel == 3 || param1.StrengthenLevel == 6 || param1.StrengthenLevel == 9 || param1.StrengthenLevel == 12))
         {
            _loc3_ = param1.Hole.split("|");
            _loc4_ = param1.StrengthenLevel / 3;
            if(_loc3_[_loc4_ - 1].split(",")[1] > 0 && param1["Hole" + _loc4_] >= 0)
            {
               _lastTipString = _lastTipString + ("\n" + _loc2_);
               return _loc5_;
            }
         }
         return null;
      }
      
      private function showOpenHoleTip(param1:InventoryItemInfo) : String
      {
         var _loc2_:String = LanguageMgr.GetTranslation("store.storeTip.openHole");
         _loc2_ = _loc2_ + (" " + LanguageMgr.GetTranslation("store.storeTip.weaponOpenProperty"));
         return _loc2_;
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
      
      public function showStrengthSuccess(param1:InventoryItemInfo, param2:Boolean) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
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
            _loc3_ = showPropertyChange(param1);
            _loc4_ = !!param2?showHoleTip(param1):null;
            if(_loc4_)
            {
               _loc3_ = _loc3_.replace("!",",");
               _loc3_ = _loc3_ + _loc4_;
            }
            createTween(strengthTweenComplete,[_loc3_]);
            ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("store.Strength.Succes.ChatSay") + _loc3_);
         }
         SoundManager.instance.pauseMusic();
         SoundManager.instance.play("063",false,false);
         _timer.start();
      }
      
      private function strengthTweenComplete(param1:String) : void
      {
         if(param1)
         {
            MessageTipManager.getInstance().show(param1);
         }
         removeTips();
      }
      
      public function showEmbedSuccess(param1:InventoryItemInfo) : void
      {
         var _loc2_:* = null;
         _lastTipString = "";
         if(isDisplayerTip)
         {
            if(!_moveSprite)
            {
               _moveSprite = new Sprite();
               addChild(_moveSprite);
            }
            _moveSprite.addChild(_successBit);
            _loc2_ = showOpenHoleTip(param1);
            createTween(embedTweenComplete);
            _lastTipString = _loc2_;
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
      
      private function __timerComplete(param1:TimerEvent) : void
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
