package sevenDayTarget.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import sevenDayTarget.model.NewPlayerRewardInfo;
   
   public class NewPlayerRewardItem extends Sprite
   {
       
      
      private var _bg:Bitmap;
      
      private var _titleText:FilterFrameText;
      
      private var _getRewardBnt:BaseButton;
      
      private var _rewardList:SimpleTileList;
      
      private var _info:NewPlayerRewardInfo;
      
      public function NewPlayerRewardItem()
      {
         super();
      }
      
      public function setInfo(param1:NewPlayerRewardInfo) : void
      {
         var _loc9_:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:Array = param1.rewardArr;
         var _loc7_:int = param1.bgType;
         var _loc6_:int = _loc2_.length;
         var _loc5_:Boolean = param1.finished;
         var _loc8_:Boolean = param1.getRewarded;
         _info = param1;
         if(!_loc5_)
         {
            _getRewardBnt = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.newplayerRewardItemRewardBnt");
            _getRewardBnt.enable = false;
         }
         else if(_loc5_ && !_loc8_)
         {
            _getRewardBnt = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.newplayerRewardItemRewardBnt");
            _getRewardBnt.enable = true;
         }
         else if(_loc8_)
         {
            _getRewardBnt = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.newplayerRewardItemRewardBnt2");
            _getRewardBnt.enable = false;
         }
         _getRewardBnt.addEventListener("click",__getReward);
         if(_loc6_ <= 4 && _loc6_ > 0 && _loc7_ == NewPlayerRewardMainView.CHONGZHI)
         {
            _bg = ComponentFactory.Instance.creat("newSevenDayAndNewPlayer.chongzhi");
            _titleText = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.titletext1");
            _titleText.text = LanguageMgr.GetTranslation("newSevenDayAndNewPlayer.chongzhitext",param1.num);
         }
         else if(_loc6_ > 4 && _loc6_ <= 8 && _loc7_ == NewPlayerRewardMainView.CHONGZHI)
         {
            _bg = ComponentFactory.Instance.creat("newSevenDayAndNewPlayer.chongzhibig");
            _titleText = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.titletext1");
            _titleText.text = LanguageMgr.GetTranslation("newSevenDayAndNewPlayer.chongzhitext",param1.num);
         }
         else if(_loc6_ <= 4 && _loc6_ > 0 && _loc7_ == NewPlayerRewardMainView.XIAOFEI)
         {
            _bg = ComponentFactory.Instance.creat("newSevenDayAndNewPlayer.xiaofei");
            _titleText = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.titletext2");
            _titleText.text = LanguageMgr.GetTranslation("newSevenDayAndNewPlayer.xiaofeitext",param1.num);
         }
         else if(_loc6_ > 4 && _loc6_ <= 8 && _loc7_ == NewPlayerRewardMainView.XIAOFEI)
         {
            _bg = ComponentFactory.Instance.creat("newSevenDayAndNewPlayer.xiaofeiibig");
            _titleText = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.titletext2");
            _titleText.text = LanguageMgr.GetTranslation("newSevenDayAndNewPlayer.xiaofeitext",param1.num);
         }
         else
         {
            _titleText = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.titletext3");
            _titleText.text = LanguageMgr.GetTranslation("newSevenDayAndNewPlayer.hunlitext");
         }
         PositionUtils.setPos(_titleText,"newSevenDayAndNewPlayer.newplayerRewardItemTitlePos");
         if(_loc6_ <= 4 && _loc6_ > 0)
         {
            PositionUtils.setPos(_getRewardBnt,"newSevenDayAndNewPlayer.newplayerRewardItemRewardBntPos");
         }
         else
         {
            PositionUtils.setPos(_getRewardBnt,"newSevenDayAndNewPlayer.newplayerRewardItemRewardBntPos2");
         }
         _rewardList = ComponentFactory.Instance.creat("newPlayerReward.simpleTileList.rewardList",[4]);
         if(_bg)
         {
            addChild(_bg);
         }
         addChild(_titleText);
         addChild(_getRewardBnt);
         addChild(_rewardList);
         _loc9_ = 0;
         while(_loc9_ < _loc2_.length)
         {
            _loc3_ = new NewPlayerRewardCell();
            _loc4_ = _loc2_[_loc9_] as InventoryItemInfo;
            _loc3_.info = ItemManager.Instance.getTemplateById(_loc4_.ItemID);
            _loc3_.itemNum = _loc4_.Count + "";
            _rewardList.addChild(_loc3_);
            _loc9_++;
         }
      }
      
      private function __getReward(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_getRewardBnt)
         {
            _getRewardBnt.backStyle = "newSevenDayAndNewPlayer.getRewardBG1";
            _getRewardBnt.enable = false;
         }
         var _loc2_:int = _info.questId;
         SocketManager.Instance.out.newPlayerReward_getReward(_loc2_);
      }
      
      private function initView(param1:int) : void
      {
      }
   }
}
