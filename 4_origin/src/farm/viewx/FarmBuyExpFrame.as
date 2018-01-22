package farm.viewx
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.view.DoubleSelectedItem;
   import farm.FarmModelController;
   import farm.modelx.SuperPetFoodPriceInfo;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class FarmBuyExpFrame extends BaseAlerFrame
   {
       
      
      private var _bg:Bitmap;
      
      private var _text:FilterFrameText;
      
      private var _currentMoney:int;
      
      private var _currentSuperPetFoodPriceInfo:SuperPetFoodPriceInfo;
      
      private var _back:MovieClip;
      
      private var _doubleSeleItem:DoubleSelectedItem;
      
      public function FarmBuyExpFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _currentMoney = FarmModelController.instance.getCurrentMoney();
         _currentSuperPetFoodPriceInfo = FarmModelController.instance.getCurrentSuperPetFoodPriceInfo();
         info = new AlertInfo(LanguageMgr.GetTranslation("farm.viewx.farmBuyExpFrame.title"),LanguageMgr.GetTranslation("farm.viewx.farmBuyExpFrame.title"),"",true,false);
         _bg = ComponentFactory.Instance.creatBitmap("asset.farm.buyExpFrameGB");
         addToContent(_bg);
         _back = ComponentFactory.Instance.creat("asset.core.stranDown");
         _back.x = 170;
         _back.y = 324;
         addToContent(_back);
         var _loc1_:int = ItemManager.Instance.getTemplateById(334102).Property3;
         _text = ComponentFactory.Instance.creatComponentByStylename("Farm.FarmMainView.buyExpExplainText");
         addToContent(_text);
         var _loc2_:String = "0";
         if(_currentSuperPetFoodPriceInfo)
         {
            _loc2_ = _currentSuperPetFoodPriceInfo.ItemCount.toString();
         }
         _text.htmlText = LanguageMgr.GetTranslation("farm.viewx.farmBuyExpFrame.explain",_currentMoney.toString(),_loc2_,_loc1_);
         addEventListener("response",__onFrameEvent);
         FarmModelController.instance.addEventListener("updateBuyExpRemainNum",__updateNum);
         _doubleSeleItem = new DoubleSelectedItem();
         _doubleSeleItem.x = 177;
         _doubleSeleItem.y = 325;
         addToContent(_doubleSeleItem);
      }
      
      protected function __updateNum(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(FarmModelController.instance.model.buyExpRemainNum > 0)
         {
            _currentMoney = FarmModelController.instance.getCurrentMoney();
            _currentSuperPetFoodPriceInfo = FarmModelController.instance.getCurrentSuperPetFoodPriceInfo();
            if(_currentSuperPetFoodPriceInfo == null)
            {
               return;
            }
            _loc2_ = ItemManager.Instance.getTemplateById(334102).Property3;
            _text.htmlText = LanguageMgr.GetTranslation("farm.viewx.farmBuyExpFrame.explain",_currentMoney.toString(),_currentSuperPetFoodPriceInfo.ItemCount.toString(),_loc2_);
         }
      }
      
      protected function __onFrameEvent(param1:FrameEvent) : void
      {
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            SoundManager.instance.playButtonSound();
            if(FarmModelController.instance.model.buyExpRemainNum <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("farm.viewx.FarmBuyExpFrame.warning"));
               return;
            }
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            _currentMoney = FarmModelController.instance.getCurrentMoney();
            CheckMoneyUtils.instance.checkMoney(_doubleSeleItem.isBind,_currentMoney,onCheckComplete);
         }
      }
      
      protected function onCheckComplete() : void
      {
         SocketManager.Instance.out.sendBuyPetExpItem(CheckMoneyUtils.instance.isBind);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      override public function dispose() : void
      {
         if(_doubleSeleItem)
         {
            ObjectUtils.disposeObject(_doubleSeleItem);
         }
         removeEventListener("response",__onFrameEvent);
         FarmModelController.instance.removeEventListener("updateBuyExpRemainNum",__updateNum);
         super.dispose();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_text);
         _text = null;
      }
   }
}
