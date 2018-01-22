package Indiana
{
   import Indiana.analyzer.IndianaGoodsItemInfo;
   import Indiana.analyzer.IndianaShopItemInfo;
   import Indiana.item.IndianaResoultLose;
   import Indiana.item.IndianaResoultSuccess;
   import Indiana.model.IndianaModel;
   import Indiana.model.IndianaShowData;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class IndianaMainInfoLogic extends Sprite implements Disposeable
   {
       
      
      private var _infoView:IndianaInfoPanel;
      
      private var _discloseView:IndiananDiscloseCountDownPanel;
      
      private var _currentView;
      
      private var _info:IndianaShopItemInfo;
      
      private var _itemInfo:IndianaGoodsItemInfo;
      
      private var _showData:IndianaShowData;
      
      private var _loseView:IndianaResoultLose;
      
      private var _successView:IndianaResoultSuccess;
      
      public function IndianaMainInfoLogic()
      {
         super();
         initEvent();
      }
      
      private function initEvent() : void
      {
         IndianaDataManager.instance.addEventListener("turn_to_announced",__turntoannouncedHandler);
      }
      
      private function __turntoannouncedHandler(param1:Event) : void
      {
         updataState();
         _currentView.setInfo(_info);
      }
      
      private function removeEvent() : void
      {
         IndianaDataManager.instance.removeEventListener("turn_to_announced",__turntoannouncedHandler);
      }
      
      private function updataState() : void
      {
         _showData = IndianaDataManager.instance.currentShowData;
         if(_showData.state == IndianaModel.INDIANA_SHOWING)
         {
            if(_showData.luckCode == 0)
            {
               if(_currentView && _currentView != _loseView)
               {
                  _currentView.visible = false;
                  if(_currentView is IndiananDiscloseCountDownPanel)
                  {
                     _currentView.stopTime();
                  }
               }
               if(_loseView == null)
               {
                  _loseView = new IndianaResoultLose();
                  addChild(_loseView);
               }
               _loseView.visible = true;
               _currentView = _loseView;
            }
            else
            {
               if(_currentView && _currentView != _successView)
               {
                  _currentView.visible = false;
                  if(_currentView is IndiananDiscloseCountDownPanel)
                  {
                     _currentView.stopTime();
                  }
               }
               if(_successView == null)
               {
                  _successView = new IndianaResoultSuccess();
                  addChild(_successView);
               }
               _successView.visible = true;
               _currentView = _successView;
            }
         }
         if(_showData.state == IndianaModel.INDIANA_COUNTDOWN)
         {
            if(_currentView && !(_currentView is IndiananDiscloseCountDownPanel))
            {
               _currentView.visible = false;
            }
            if(_discloseView == null)
            {
               _discloseView = new IndiananDiscloseCountDownPanel();
               addChild(_discloseView);
            }
            _discloseView.visible = true;
            _currentView = _discloseView;
         }
         if(_showData.state == IndianaModel.INDIANA_DOING)
         {
            if(_currentView && !(_currentView is IndianaInfoPanel))
            {
               _currentView.visible = false;
               if(_currentView is IndiananDiscloseCountDownPanel)
               {
                  _currentView.stopTime();
               }
            }
            if(_infoView == null)
            {
               _infoView = new IndianaInfoPanel();
               addChild(_infoView);
            }
            _infoView.visible = true;
            _currentView = _infoView;
         }
      }
      
      public function upDate() : void
      {
         _info = IndianaDataManager.instance.getCurrentShopItem;
         if(_info)
         {
            _itemInfo = IndianaDataManager.instance.getIndianaGoodsItemInfoByshopId(_info.ShopId);
         }
         updataState();
         _currentView.setInfo(_info);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeAllChildren(this);
         _currentView = null;
         _discloseView = null;
         _infoView = null;
      }
   }
}
