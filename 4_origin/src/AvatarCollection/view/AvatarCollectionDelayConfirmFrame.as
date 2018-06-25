package AvatarCollection.view
{
   import AvatarCollection.AvatarCollectionManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.NumberSelecter;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   
   public class AvatarCollectionDelayConfirmFrame extends BaseAlerFrame
   {
       
      
      private var _numberSelecter:NumberSelecter;
      
      private var _text:FilterFrameText;
      
      private var _needFoodText:FilterFrameText;
      
      private var _dayHonour:int;
      
      private var count:Number;
      
      public function AvatarCollectionDelayConfirmFrame()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         var alertInfo:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("avatarCollection.delayConfirmFrame.titleTxt"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         alertInfo.moveEnable = false;
         info = alertInfo;
         this.escEnable = true;
         _text = ComponentFactory.Instance.creatComponentByStylename("avatarColl.delayConfirmFrame.dayNameTxt");
         _text.text = LanguageMgr.GetTranslation("avatarCollection.delayConfirmFrame.dayNameTxt");
         _numberSelecter = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.NumberSelecter");
         _numberSelecter.addEventListener("change",__seleterChange);
         PositionUtils.setPos(_numberSelecter,"avatarColl.delayConfirmFrame.numberSelecterPos");
         _needFoodText = ComponentFactory.Instance.creatComponentByStylename("avatarColl.delayConfirmFrame.promptTxt");
         addToContent(_text);
         addToContent(_numberSelecter);
         addToContent(_needFoodText);
      }
      
      private function __seleterChange(event:Event) : void
      {
         SoundManager.instance.play("008");
         _needFoodText.htmlText = LanguageMgr.GetTranslation("avatarCollection.delayConfirmFrame.promptTxt",_numberSelecter.currentValue * _dayHonour,count);
      }
      
      public function show(needHonor:int, maxCount:int) : void
      {
         count = AvatarCollectionManager.instance.getDelayTimeCollectionCount();
         _dayHonour = needHonor;
         _needFoodText.htmlText = LanguageMgr.GetTranslation("avatarCollection.delayConfirmFrame.promptTxt",_dayHonour,count);
         _numberSelecter.valueLimit = "1,99";
      }
      
      public function get selectValue() : int
      {
         return _numberSelecter.currentValue;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _numberSelecter = null;
         _text = null;
         _needFoodText = null;
      }
   }
}
