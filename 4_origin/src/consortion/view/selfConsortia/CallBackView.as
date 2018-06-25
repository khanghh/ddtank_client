package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import consortion.ConsortionModelManager;
   import consortion.data.CallBackModel;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class CallBackView extends Sprite implements Disposeable
   {
       
      
      private var _backBtn:SimpleBitmapButton;
      
      private var _list:VBox;
      
      private var _panel:ScrollPanel;
      
      private var _isOpen:Boolean;
      
      private var _callBackModel:CallBackModel;
      
      public function CallBackView()
      {
         super();
         _callBackModel = ConsortionModelManager.Instance.model.callBackModel;
         ConsortionModelManager.Instance.addEventListener("event_consortia_back_info",onQueryConsortionCallBackInfo);
         SocketManager.Instance.out.queryConsortionCallBackInfo();
      }
      
      private function onQueryConsortionCallBackInfo(evt:Event) : void
      {
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var serverDateTime:Number = TimeManager.Instance.Now().time;
         _isOpen = serverDateTime >= _callBackModel.startTime.time && serverDateTime <= _callBackModel.endTime.time;
         if(_isOpen)
         {
            UICreatShortcut.creatAndAdd("consortion.callBackView.titleBg",this);
            UICreatShortcut.creatAndAdd("consortion.callBackView.titleLine",this);
            UICreatShortcut.creatTextAndAdd("consortion.callBackView.titleConTf",LanguageMgr.GetTranslation("consortion.callBackView.titleCon"),this);
            UICreatShortcut.creatTextAndAdd("consortion.callBackView.titleCountTf",LanguageMgr.GetTranslation("consortion.callBackView.titleCount"),this);
            UICreatShortcut.creatTextAndAdd("consortion.callBackView.titleRewardTf",LanguageMgr.GetTranslation("consortion.callBackView.titleReward"),this);
            _list = new VBox();
            _list.spacing = -20;
            _panel = ComponentFactory.Instance.creatComponentByStylename("consortion.callBackView.ScrollPanel");
            _panel.setView(_list);
            updateScrollPanel();
            addChild(_panel);
            UICreatShortcut.creatAndAdd("consortion.callBackView.helpBg",this);
            UICreatShortcut.creatTextAndAdd("consortion.callBackView.helpTf",LanguageMgr.GetTranslation("consortion.callBackView.help"),this);
         }
         else
         {
            UICreatShortcut.creatAndAdd("asset.placardAndEvent.callback9",this);
         }
         _backBtn = UICreatShortcut.creatAndAdd("asset.placardAndEvent.callBackView.backBtn",this);
      }
      
      private function updateScrollPanel() : void
      {
         var item:* = null;
         var i:int = 0;
         _list.removeAllChild();
         var arr:Array = _callBackModel.awardArr;
         for(i = 0; i < arr.length; )
         {
            item = new CallBackItem();
            item.setData(i);
            _list.addChild(item);
            i++;
         }
         _panel.invalidateViewport();
      }
      
      private function onGetConsortionCallBackAward(evt:Event) : void
      {
         updateScrollPanel();
      }
      
      private function initEvent() : void
      {
         _backBtn.addEventListener("click",onClick);
         ConsortionModelManager.Instance.addEventListener("event_consortia_back_award",onGetConsortionCallBackAward);
      }
      
      private function removeEvent() : void
      {
         _backBtn && _backBtn.removeEventListener("click",onClick);
         ConsortionModelManager.Instance.removeEventListener("event_consortia_back_info",onQueryConsortionCallBackInfo);
         ConsortionModelManager.Instance.removeEventListener("event_consortia_back_award",onGetConsortionCallBackAward);
      }
      
      private function onClick(evt:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         ConsortionModelManager.Instance.dispatchEvent(new Event("leave_call_back_view"));
      }
      
      public function dispose() : void
      {
         removeEvent();
         _backBtn = null;
         _list = null;
         _panel = null;
         _callBackModel = null;
      }
   }
}
