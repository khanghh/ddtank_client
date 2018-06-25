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
         var self:SelfInfo = PlayerManager.Instance.Self;
         var p:Point = ComponentFactory.Instance.creatCustomObject("core.levelReward.posPlayer");
         _playerView = CharactoryFactory.createCharacter(self,"show",true) as ShowCharacter;
         _playerView.doAction("win");
         _playerView.show(true,1,true);
         _playerView.x = p.x;
         _playerView.y = p.y;
         if(!self.getSuitesHide() && self.getSuitsType() == 1)
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
      
      private function showLv(lv:int) : void
      {
         var i:int = 0;
         var bmp:* = null;
         var arr:Array = lv.toString().split("");
         var posX:int = _up.x + (arr.length > 1?252:Number(266));
         var posY:int = _up.y - 49;
         for(i = 0; i < arr.length; )
         {
            bmp = ComponentFactory.Instance.creatBitmap("asset.core.levelRewardRed_" + arr[i]);
            bmp.x = posX + i * 25;
            bmp.y = posY;
            addToContent(bmp);
            i++;
         }
      }
      
      public function show($level:int) : void
      {
         if($level > 15)
         {
            return;
         }
         level = $level;
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
      
      public function set level(value:int) : void
      {
         if(value > 15)
         {
            return;
         }
         _item1 = ComponentFactory.Instance.creatCustomObject("core.levelRewardItem1");
         _item1.setStyle(value);
         addToContent(_item1);
         showLv(value);
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
