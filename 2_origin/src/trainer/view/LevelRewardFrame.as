package trainer.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.manager.PlayerManager;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ShowCharacter;
   import flash.display.Bitmap;
   import flash.geom.Point;
   import quest.TaskManager;
   import trainer.controller.WeakGuildManager;
   
   public class LevelRewardFrame extends BaseAlerFrame
   {
       
      
      private var _bg:MutipleImage;
      
      private var _playerView:ShowCharacter;
      
      private var _up:MutipleImage;
      
      private var _item1:LevelRewardItem;
      
      public function LevelRewardFrame()
      {
         super();
         initView();
         info = new AlertInfo();
         info.frameCenter = true;
         info.bottomGap = 16;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("asset.core.levelRewardBg");
         addToContent(_bg);
         var _loc2_:SelfInfo = PlayerManager.Instance.Self;
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("core.levelReward.posPlayer");
         _playerView = CharactoryFactory.createCharacter(_loc2_,"show",true) as ShowCharacter;
         _playerView.doAction("win");
         _playerView.show(true,1,true);
         _playerView.x = _loc1_.x;
         _playerView.y = _loc1_.y;
         if(!_loc2_.getSuitesHide() && _loc2_.getSuitsType() == 1)
         {
            var _loc3_:* = 1.3;
            _playerView.scaleY = _loc3_;
            _playerView.scaleX = _loc3_;
         }
         else
         {
            _loc3_ = 1.4;
            _playerView.scaleY = _loc3_;
            _playerView.scaleX = _loc3_;
         }
         addToContent(_playerView);
         _up = ComponentFactory.Instance.creatComponentByStylename("asset.core.levelRewardUp3");
         addToContent(_up);
      }
      
      private function showLv(param1:int) : void
      {
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc5_:Array = param1.toString().split("");
         var _loc4_:int = _up.x + (_loc5_.length > 1?252:Number(266));
         var _loc3_:int = _up.y - 49;
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc2_ = ComponentFactory.Instance.creatBitmap("asset.core.levelRewardRed_" + _loc5_[_loc6_]);
            _loc2_.x = _loc4_ + _loc6_ * 25;
            _loc2_.y = _loc3_;
            addToContent(_loc2_);
            _loc6_++;
         }
      }
      
      public function show(param1:int) : void
      {
         if(param1 > 15)
         {
            return;
         }
         level = param1;
         LayerManager.Instance.addToLayer(this,2,true,2);
      }
      
      public function hide() : void
      {
         dispose();
         if(WeakGuildManager.Instance.newTask)
         {
            TaskManager.instance.showGetNewQuest();
            WeakGuildManager.Instance.newTask = false;
         }
      }
      
      public function set level(param1:int) : void
      {
         if(param1 > 15)
         {
            return;
         }
         _item1 = ComponentFactory.Instance.creatCustomObject("core.levelRewardItem1");
         _item1.setStyle(param1);
         addToContent(_item1);
         showLv(param1);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _playerView = null;
         _up = null;
         if(_item1)
         {
            _item1.dispose();
            _item1 = null;
         }
         super.dispose();
      }
   }
}
