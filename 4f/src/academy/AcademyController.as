package academy
{
   import academy.view.AcademyView;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.AcademyMemberListAnalyze;
   import ddt.data.player.AcademyPlayerInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.PlayerManager;
   import ddt.states.BaseStateView;
   import ddt.view.MainToolBar;
   import flash.display.Sprite;
   
   public class AcademyController extends BaseStateView
   {
       
      
      private var _model:AcademyModel;
      
      private var _view:AcademyView;
      
      private var _chatFrame:Sprite;
      
      public function AcademyController(){super();}
      
      override public function prepare() : void{}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      private function init() : void{}
      
      override public function dispose() : void{}
      
      public function loadAcademyMemberList(param1:Boolean = true, param2:Boolean = false, param3:int = 1, param4:String = "", param5:Boolean = false) : void{}
      
      public function get model() : AcademyModel{return null;}
      
      public function set currentAcademyInfo(param1:AcademyPlayerInfo) : void{}
      
      private function __loadAcademyMemberList(param1:AcademyMemberListAnalyze) : void{}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      override public function getType() : String{return null;}
      
      override public function getBackType() : String{return null;}
   }
}
