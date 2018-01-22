package church.view.invite
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import consortion.ConsortionModelManager;
   import ddt.manager.PlayerManager;
   import flash.display.Sprite;
   
   public class ChurchInviteController
   {
       
      
      private var _view:ChurchInviteView;
      
      private var _model:ChurchInviteModel;
      
      public function ChurchInviteController()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _model = new ChurchInviteModel();
         _view = ComponentFactory.Instance.creat("church.invite.ChurchInviteView");
         _view.controller = this;
         _view.model = _model;
      }
      
      public function getView() : Sprite
      {
         return _view;
      }
      
      public function refleshList(param1:int, param2:int = 0) : void
      {
         if(param1 == 0)
         {
            setList(0,PlayerManager.Instance.onlineFriendList);
         }
         else if(param1 == 1)
         {
            setList(1,ConsortionModelManager.Instance.model.onlineConsortiaMemberList);
         }
      }
      
      private function isOnline(param1:*) : Boolean
      {
         return param1.State == 1;
      }
      
      private function setList(param1:int, param2:Array) : void
      {
         _model.setList(param1,param2);
      }
      
      public function hide() : void
      {
         _view.hide();
      }
      
      public function showView() : void
      {
         LayerManager.Instance.clearnGameDynamic();
         LayerManager.Instance.clearnStageDynamic();
         _view.show();
      }
      
      public function dispose() : void
      {
         _model.dispose();
         _model = null;
         if(_view && _view.parent)
         {
            _view.parent.removeChild(_view);
         }
         if(_view)
         {
            _view.dispose();
         }
         _view = null;
      }
   }
}
