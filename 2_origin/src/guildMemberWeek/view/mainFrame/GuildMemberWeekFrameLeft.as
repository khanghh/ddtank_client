package guildMemberWeek.view.mainFrame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import guildMemberWeek.items.ShowGuildMemberDataItem;
   import guildMemberWeek.manager.GuildMemberWeekManager;
   
   public class GuildMemberWeekFrameLeft extends Sprite implements Disposeable
   {
       
      
      private var _itemList:Vector.<ShowGuildMemberDataItem>;
      
      private var _list:VBox;
      
      public function GuildMemberWeekFrameLeft()
      {
         super();
         initView();
      }
      
      public function set itemList(param1:Vector.<ShowGuildMemberDataItem>) : void
      {
         this._itemList = param1;
      }
      
      public function get itemList() : Vector.<ShowGuildMemberDataItem>
      {
         return this._itemList;
      }
      
      private function initView() : void
      {
         var _loc1_:* = null;
         _list = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.RankingTopTenListBox");
         itemList = new Vector.<ShowGuildMemberDataItem>();
         var _loc2_:int = 10;
         var _loc3_:int = 0;
         _loc3_;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("guildmemberweek.MainFrame.Left.ShowGuildMemberDataItem");
            _loc1_.initView(_loc3_ + 1);
            _loc1_.initAddPointBook(0);
            _loc1_.initItemCell(GuildMemberWeekManager.instance.model.TopTenGiftData[_loc3_]);
            itemList.push(_loc1_);
            _list.addChild(itemList[_loc3_]);
            _loc3_++;
         }
         addChild(_list);
         UpTop10data("Gift");
      }
      
      public function UpTop10data(param1:String) : void
      {
         var _loc2_:int = 10;
         var _loc3_:int = 0;
         _loc3_;
         while(_loc3_ < _loc2_)
         {
            if(param1 == "Member")
            {
               if(GuildMemberWeekManager.instance.model.TopTenMemberData[_loc3_] != null)
               {
                  itemList[_loc3_].initMember(GuildMemberWeekManager.instance.model.TopTenMemberData[_loc3_][1],GuildMemberWeekManager.instance.model.TopTenMemberData[_loc3_][3]);
               }
            }
            else if(param1 == "PointBook")
            {
               itemList[_loc3_].initAddPointBook(GuildMemberWeekManager.instance.model.TopTenAddPointBook[_loc3_]);
            }
            else if(param1 == "Gift")
            {
               itemList[_loc3_].initItemCell(GuildMemberWeekManager.instance.model.TopTenGiftData[_loc3_]);
            }
            _loc3_++;
         }
      }
      
      private function disposeItems() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(itemList)
         {
            _loc2_ = 0;
            _loc1_ = itemList.length;
            _loc2_;
            while(_loc2_ < _loc1_)
            {
               ObjectUtils.disposeObject(itemList[_loc2_]);
               itemList[_loc2_] = null;
               _loc2_++;
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
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
