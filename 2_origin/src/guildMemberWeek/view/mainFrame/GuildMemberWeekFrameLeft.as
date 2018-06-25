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
      
      public function set itemList(value:Vector.<ShowGuildMemberDataItem>) : void
      {
         this._itemList = value;
      }
      
      public function get itemList() : Vector.<ShowGuildMemberDataItem>
      {
         return this._itemList;
      }
      
      private function initView() : void
      {
         var item:* = null;
         _list = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.RankingTopTenListBox");
         itemList = new Vector.<ShowGuildMemberDataItem>();
         var L:int = 10;
         var i:int = 0;
         i;
         while(i < L)
         {
            item = ComponentFactory.Instance.creatCustomObject("guildmemberweek.MainFrame.Left.ShowGuildMemberDataItem");
            item.initView(i + 1);
            item.initAddPointBook(0);
            item.initItemCell(GuildMemberWeekManager.instance.model.TopTenGiftData[i]);
            itemList.push(item);
            _list.addChild(itemList[i]);
            i++;
         }
         addChild(_list);
         UpTop10data("Gift");
      }
      
      public function UpTop10data(UpType:String) : void
      {
         var L:int = 10;
         var i:int = 0;
         i;
         while(i < L)
         {
            if(UpType == "Member")
            {
               if(GuildMemberWeekManager.instance.model.TopTenMemberData[i] != null)
               {
                  itemList[i].initMember(GuildMemberWeekManager.instance.model.TopTenMemberData[i][1],GuildMemberWeekManager.instance.model.TopTenMemberData[i][3]);
               }
            }
            else if(UpType == "PointBook")
            {
               itemList[i].initAddPointBook(GuildMemberWeekManager.instance.model.TopTenAddPointBook[i]);
            }
            else if(UpType == "Gift")
            {
               itemList[i].initItemCell(GuildMemberWeekManager.instance.model.TopTenGiftData[i]);
            }
            i++;
         }
      }
      
      private function disposeItems() : void
      {
         var i:int = 0;
         var L:int = 0;
         if(itemList)
         {
            i = 0;
            L = itemList.length;
            i;
            while(i < L)
            {
               ObjectUtils.disposeObject(itemList[i]);
               itemList[i] = null;
               i++;
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
