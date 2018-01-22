package horse.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import horse.HorseControl;
   import horse.HorseManager;
   import horse.data.HorseTemplateVo;
   import horse.horsePicCherish.HorsePicCherishFrame;
   import trainer.view.NewHandContainer;
   
   public class HorseFrameRightTopView extends Sprite implements Disposeable
   {
       
      
      private var _addPropertyValueTxtList:Vector.<FilterFrameText>;
      
      private var _skillBtn:SimpleBitmapButton;
      
      private var _picBtn:SimpleBitmapButton;
      
      private var _amuletBtn:SimpleBitmapButton;
      
      public function HorseFrameRightTopView()
      {
         super();
         initView();
         initEvent();
         refreshView();
         guideHandler();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _addPropertyValueTxtList = new Vector.<FilterFrameText>();
         var _loc4_:Array = LanguageMgr.GetTranslation("horse.addPropertyNameStr").split(",");
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("horse.frame.addPorpertyNameTxt");
            _loc2_.text = _loc4_[_loc3_];
            _loc2_.y = _loc2_.y + _loc3_ * 29;
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("horse.frame.addPorpertyValueTxt");
            _loc1_.text = "0";
            _loc1_.y = _loc1_.y + _loc3_ * 29;
            _addPropertyValueTxtList.push(_loc1_);
            addChild(_loc2_);
            addChild(_loc1_);
            _loc3_++;
         }
         _skillBtn = ComponentFactory.Instance.creatComponentByStylename("horse.frame.skillBtn");
         _picBtn = ComponentFactory.Instance.creatComponentByStylename("horse.frame.picBtn");
         _amuletBtn = ComponentFactory.Instance.creatComponentByStylename("horse.frame.amuletBtn");
         addChild(_skillBtn);
         addChild(_picBtn);
         addChild(_amuletBtn);
      }
      
      private function initEvent() : void
      {
         _skillBtn.addEventListener("click",skillClickHandler,false,0,true);
         _picBtn.addEventListener("click",picClickHandler,false,0,true);
         _amuletBtn.addEventListener("click",__onAmuletHandler);
         HorseManager.instance.addEventListener("horseUpHorseStep2",upHorseHandler);
         HorseManager.instance.addEventListener("horsePreNextEffect",refreshNextView);
         HorseManager.instance.addEventListener("horseRefreshCurEffect",refreshView);
      }
      
      private function upHorseHandler(param1:Event) : void
      {
         refreshView();
         guideHandler();
      }
      
      private function guideHandler() : void
      {
         if(!PlayerManager.Instance.Self.isNewOnceFinish(113) && HorseManager.instance.curLevel >= 1)
         {
            NewHandContainer.Instance.showArrow(128,0,new Point(530,154),"","",this);
         }
      }
      
      private function skillClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(!PlayerManager.Instance.Self.isNewOnceFinish(113) && HorseManager.instance.curLevel >= 1)
         {
            SocketManager.Instance.out.syncWeakStep(113);
            NewHandContainer.Instance.clearArrowByID(128);
         }
         var _loc2_:HorseSkillFrame = ComponentFactory.Instance.creatComponentByStylename("HorseSkillFrame");
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
      
      private function picClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:HorsePicCherishFrame = ComponentFactory.Instance.creatComponentByStylename("HorsePicCherishFrame");
         _loc2_.index = 1;
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
      
      private function __onAmuletHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.Grade < 31)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",31));
            return;
         }
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(141))
         {
            SocketManager.Instance.out.syncWeakStep(141);
         }
         HorseControl.instance.openHorseMainView();
      }
      
      private function refreshView(param1:Event = null) : void
      {
         var _loc2_:HorseTemplateVo = HorseManager.instance.curHorseTemplateInfo;
         _addPropertyValueTxtList[0].text = _loc2_.AddDamage.toString();
         _addPropertyValueTxtList[1].text = _loc2_.AddGuard.toString();
         _addPropertyValueTxtList[2].text = _loc2_.AddBlood.toString();
         _addPropertyValueTxtList[3].text = _loc2_.MagicAttack.toString();
         _addPropertyValueTxtList[4].text = _loc2_.MagicDefence.toString();
      }
      
      private function refreshNextView(param1:Event = null) : void
      {
         var _loc2_:int = HorseManager.instance.curLevel;
         var _loc4_:int = (int(_loc2_ / 10) + 1) * 10;
         var _loc3_:HorseTemplateVo = HorseManager.instance.getHorseTemplateInfoByLevel(_loc4_);
         if(!_loc3_)
         {
            return;
         }
         _addPropertyValueTxtList[0].text = _loc3_.AddDamage.toString();
         _addPropertyValueTxtList[1].text = _loc3_.AddGuard.toString();
         _addPropertyValueTxtList[2].text = _loc3_.AddBlood.toString();
         _addPropertyValueTxtList[3].text = _loc3_.MagicAttack.toString();
         _addPropertyValueTxtList[4].text = _loc3_.MagicDefence.toString();
         _addPropertyValueTxtList[0].textColor = 15216382;
         _addPropertyValueTxtList[1].textColor = 15216382;
         _addPropertyValueTxtList[2].textColor = 15216382;
         _addPropertyValueTxtList[3].textColor = 15216382;
         _addPropertyValueTxtList[4].textColor = 15216382;
      }
      
      private function removeEvent() : void
      {
         _skillBtn.removeEventListener("click",skillClickHandler);
         _picBtn.removeEventListener("click",picClickHandler);
         _amuletBtn.removeEventListener("click",__onAmuletHandler);
         HorseManager.instance.removeEventListener("horseUpHorseStep2",upHorseHandler);
         HorseManager.instance.removeEventListener("horsePreNextEffect",refreshNextView);
         HorseManager.instance.removeEventListener("horseRefreshCurEffect",refreshView);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _addPropertyValueTxtList = null;
         _skillBtn = null;
         _picBtn = null;
         _amuletBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
