package redPackage.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import redPackage.RedPackageManager;
   
   public class RedPackageConsortiaGainedRecordFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _nickTitleText:FilterFrameText;
      
      private var _totalMoneyText:FilterFrameText;
      
      private var _wishWordsText:FilterFrameText;
      
      private var _listPanel:ListPanel;
      
      public function RedPackageConsortiaGainedRecordFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         titleText = LanguageMgr.GetTranslation("redpkg.frameTitle.gainRecord");
         escEnable = true;
         _bg = ComponentFactory.Instance.creatBitmap("asset.consortionGainRecord.bg");
         _bg.x = 16;
         _bg.y = 42;
         addToContent(_bg);
         _nickTitleText = ComponentFactory.Instance.creat("redpkg.consortionGain.GainRecord.nickTxt");
         addToContent(_nickTitleText);
         _totalMoneyText = ComponentFactory.Instance.creat("redpkg.consortionGain.GainRecord.moneyTxt");
         addToContent(_totalMoneyText);
         _wishWordsText = ComponentFactory.Instance.creat("redpkg.consortionGain.GainRecord.wishWordsTxt");
         addToContent(_wishWordsText);
         _listPanel = ComponentFactory.Instance.creat("redpkg.gainRecord.ListPanel");
         addToContent(_listPanel);
         addEventListener("response",_response);
         update();
      }
      
      public function update() : void
      {
         var dataObj:Object = RedPackageManager.getInstance().gainRecordObj;
         _nickTitleText.text = LanguageMgr.GetTranslation("redpkg.consortion.gainHistory.title",dataObj.nick);
         _totalMoneyText.text = dataObj.moneyNum;
         _wishWordsText.text = dataObj.wishWords;
         _listPanel.vectorListModel.clear();
         _listPanel.vectorListModel.appendAll(dataObj.arr);
      }
      
      private function _response(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            close();
         }
      }
      
      private function close() : void
      {
         SoundManager.instance.play("008");
         ObjectUtils.disposeObject(this);
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",_response);
         super.dispose();
         if(_bg != null)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_nickTitleText != null)
         {
            ObjectUtils.disposeObject(_nickTitleText);
            _nickTitleText = null;
         }
         if(_totalMoneyText != null)
         {
            ObjectUtils.disposeObject(_totalMoneyText);
            _totalMoneyText = null;
         }
         if(_listPanel != null)
         {
            ObjectUtils.disposeObject(_listPanel);
            _listPanel = null;
         }
      }
   }
}
