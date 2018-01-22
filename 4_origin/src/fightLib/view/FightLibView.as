package fightLib.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.PlayerManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class FightLibView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Sprite;
      
      private var _title:Bitmap;
      
      private var _playerInfoView:FightLibPlayerInfoView;
      
      private var _lessonsView:LessonsView;
      
      public function FightLibView()
      {
         super();
         configUI();
         hideGuide();
      }
      
      public function dispose() : void
      {
         if(_playerInfoView)
         {
            ObjectUtils.disposeObject(_playerInfoView);
            _playerInfoView = null;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         if(_lessonsView)
         {
            ObjectUtils.disposeObject(_lessonsView);
            _lessonsView = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function startup() : void
      {
         _playerInfoView.info = PlayerInfo(PlayerManager.Instance.Self);
      }
      
      public function hideGuide() : void
      {
         _lessonsView.getGuild().stop();
         _lessonsView.getGuild().visible = false;
      }
      
      public function showGuild(param1:int) : void
      {
         _lessonsView.hideShine();
         if(!_lessonsView.getGuild().visible)
         {
            _lessonsView.getGuild().visible = true;
         }
         _lessonsView.showShine(param1);
         _lessonsView.getGuild().gotoAndStop(param1);
      }
      
      private function configUI() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.fightlib.bgImg");
         addChild(_bg);
         _playerInfoView = ComponentFactory.Instance.creatCustomObject("fightLib.view.FightLibPlayerInfoView");
         addChild(_playerInfoView);
         _lessonsView = ComponentFactory.Instance.creatCustomObject("fightLib.view.LessonsView");
         addChild(_lessonsView);
      }
   }
}
