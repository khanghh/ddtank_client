package guildMemberWeek.view.mainFrame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import guildMemberWeek.items.AddRankingRecordItem;
   import guildMemberWeek.manager.GuildMemberWeekManager;
   
   public class GuildMemberWeekFrameRight extends Sprite implements Disposeable
   {
       
      
      private var _panel:ScrollPanel;
      
      private var _list:VBox;
      
      private var _itemList:Vector.<AddRankingRecordItem>;
      
      public function GuildMemberWeekFrameRight()
      {
         super();
         initView();
      }
      
      public function set itemList(param1:Vector.<AddRankingRecordItem>) : void
      {
         this._itemList = param1;
      }
      
      public function get itemList() : Vector.<AddRankingRecordItem>
      {
         return this._itemList;
      }
      
      private function initView() : void
      {
         _list = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.RankingRecordListBox");
         _panel = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.MainFrameRight.scrollpanel");
         itemList = new Vector.<AddRankingRecordItem>();
         _panel.setView(_list);
         _panel.invalidateViewport();
         addChild(_panel);
      }
      
      public function ClearRecord() : void
      {
         disposeItems();
         itemList = new Vector.<AddRankingRecordItem>();
      }
      
      public function UpRecord() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = GuildMemberWeekManager.instance.model.AddRanking.length;
         var _loc3_:int = itemList.length;
         _loc3_;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("guildmemberweek.MainFrame.Right.AddRankingRecordItem");
            _loc1_.initText(GuildMemberWeekManager.instance.model.AddRanking[_loc3_]);
            itemList.push(_loc1_);
            _list.addChild(itemList[_loc3_]);
            _loc3_++;
         }
         _panel.invalidateViewport();
      }
      
      private function disposeItems() : void
      {
         var _loc1_:int = 0;
         if(itemList)
         {
            _loc1_ = 0;
            while(_loc1_ < itemList.length)
            {
               ObjectUtils.disposeObject(itemList[_loc1_]);
               itemList[_loc1_] = null;
               _loc1_++;
            }
            itemList = null;
         }
      }
      
      public function dispose() : void
      {
         disposeItems();
         ObjectUtils.disposeAllChildren(_list);
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeAllChildren(_panel);
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
