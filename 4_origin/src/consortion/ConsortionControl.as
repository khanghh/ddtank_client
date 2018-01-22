package consortion
{
   import consortion.view.club.ClubView;
   import consortion.view.selfConsortia.SelfConsortiaView;
   import ddt.manager.ChatManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.states.BaseStateView;
   import ddt.view.MainToolBar;
   import flash.events.Event;
   
   public class ConsortionControl extends BaseStateView
   {
       
      
      private var _club:ClubView;
      
      private var _selfConsortia:SelfConsortiaView;
      
      private var _state:String;
      
      public function ConsortionControl()
      {
         super();
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         MainToolBar.Instance.show();
         ChatManager.Instance.state = 12;
         if(PlayerManager.Instance.Self.ConsortiaID != 0)
         {
            ChatManager.Instance.input.savePreChannel();
            ChatManager.Instance.inputChannel = 3;
         }
         SocketManager.Instance.out.sendCurrentState(1);
         initEvent();
         enterCurrentView();
         addChild(ChatManager.Instance.view);
         if(param2 is Function)
         {
            param2();
         }
      }
      
      private function enterCurrentView() : void
      {
         if(PlayerManager.Instance.Self.ConsortiaID != 0)
         {
            consortiaState = "selfConsortia";
         }
         else
         {
            consortiaState = "consortiaClub";
         }
      }
      
      private function set consortiaState(param1:String) : void
      {
         if(_state == param1)
         {
            return;
         }
         _state = param1;
         if(param1 == "consortiaClub")
         {
            if(_selfConsortia)
            {
               _selfConsortia.dispose();
            }
            _selfConsortia = null;
            if(_club == null)
            {
               _club = new ClubView();
            }
            _club.enterClub();
            addChildAt(_club,0);
         }
         else
         {
            if(_club)
            {
               _club.dispose();
            }
            _club = null;
            if(_selfConsortia == null)
            {
               _selfConsortia = new SelfConsortiaView();
            }
            _selfConsortia.enterSelfConsortion();
            addChildAt(_selfConsortia,0);
         }
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         super.leaving(param1);
         _state = "";
         removeEvent();
         if(_club)
         {
            _club.dispose();
         }
         _club = null;
         if(_selfConsortia)
         {
            _selfConsortia.dispose();
         }
         _selfConsortia = null;
         MainToolBar.Instance.hide();
         ChatManager.Instance.input.revertChannel();
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      override public function getType() : String
      {
         return "consortia";
      }
      
      private function initEvent() : void
      {
         ConsortionModelManager.Instance.addEventListener("consortionStateChange",____consortiaStateChannge);
      }
      
      private function removeEvent() : void
      {
         ConsortionModelManager.Instance.removeEventListener("consortionStateChange",____consortiaStateChannge);
      }
      
      private function ____consortiaStateChannge(param1:Event) : void
      {
         enterCurrentView();
      }
   }
}
