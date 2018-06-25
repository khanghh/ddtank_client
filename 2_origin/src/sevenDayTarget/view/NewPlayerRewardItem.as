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
      
      public function setInfo(info:NewPlayerRewardInfo) : void
      {
         var i:int = 0;
         var cell:* = null;
         var itemInfo:* = null;
         var arr:Array = info.rewardArr;
         var type:int = info.bgType;
         var len:int = arr.length;
         var isfinished:Boolean = info.finished;
         var getRewarded:Boolean = info.getRewarded;
         _info = info;
         if(!isfinished)
         {
            _getRewardBnt = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.newplayerRewardItemRewardBnt");
            _getRewardBnt.enable = false;
         }
         else if(isfinished && !getRewarded)
         {
            _getRewardBnt = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.newplayerRewardItemRewardBnt");
            _getRewardBnt.enable = true;
         }
         else if(getRewarded)
         {
            _getRewardBnt = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.newplayerRewardItemRewardBnt2");
            _getRewardBnt.enable = false;
         }
         _getRewardBnt.addEventListener("click",__getReward);
         if(len <= 4 && len > 0 && type == NewPlayerRewardMainView.CHONGZHI)
         {
            _bg = ComponentFactory.Instance.creat("newSevenDayAndNewPlayer.chongzhi");
            _titleText = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.titletext1");
            _titleText.text = LanguageMgr.GetTranslation("newSevenDayAndNewPlayer.chongzhitext",info.num);
         }
         else if(len > 4 && len <= 8 && type == NewPlayerRewardMainView.CHONGZHI)
         {
            _bg = ComponentFactory.Instance.creat("newSevenDayAndNewPlayer.chongzhibig");
            _titleText = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.titletext1");
            _titleText.text = LanguageMgr.GetTranslation("newSevenDayAndNewPlayer.chongzhitext",info.num);
         }
         else if(len <= 4 && len > 0 && type == NewPlayerRewardMainView.XIAOFEI)
         {
            _bg = ComponentFactory.Instance.creat("newSevenDayAndNewPlayer.xiaofei");
            _titleText = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.titletext2");
            _titleText.text = LanguageMgr.GetTranslation("newSevenDayAndNewPlayer.xiaofeitext",info.num);
         }
         else if(len > 4 && len <= 8 && type == NewPlayerRewardMainView.XIAOFEI)
         {
            _bg = ComponentFactory.Instance.creat("newSevenDayAndNewPlayer.xiaofeiibig");
            _titleText = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.titletext2");
            _titleText.text = LanguageMgr.GetTranslation("newSevenDayAndNewPlayer.xiaofeitext",info.num);
         }
         else
         {
            _titleText = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.titletext3");
            _titleText.text = LanguageMgr.GetTranslation("newSevenDayAndNewPlayer.hunlitext");
         }
         PositionUtils.setPos(_titleText,"newSevenDayAndNewPlayer.newplayerRewardItemTitlePos");
         if(len <= 4 && len > 0)
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
         for(i = 0; i < arr.length; )
         {
            cell = new NewPlayerRewardCell();
            itemInfo = arr[i] as InventoryItemInfo;
            cell.info = ItemManager.Instance.getTemplateById(itemInfo.ItemID);
            cell.itemNum = itemInfo.Count + "";
            _rewardList.addChild(cell);
            i++;
         }
      }
      
      private function __getReward(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_getRewardBnt)
         {
            _getRewardBnt.backStyle = "newSevenDayAndNewPlayer.getRewardBG1";
            _getRewardBnt.enable = false;
         }
         var questionId:int = _info.questId;
         SocketManager.Instance.out.newPlayerReward_getReward(questionId);
      }
      
      private function initView(type:int) : void
      {
      }
   }
}
