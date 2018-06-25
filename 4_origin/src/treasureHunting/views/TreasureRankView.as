package treasureHunting.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.RouletteManager;
   import ddt.view.caddyII.CaddyEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import treasureHunting.items.LuckRankItem;
   
   public class TreasureRankView extends Sprite implements Disposeable
   {
       
      
      private var _rankBG:Bitmap;
      
      private var _itemBGDeep:Bitmap;
      
      private var _itemBGLighter:Bitmap;
      
      private var _ranklist:VBox;
      
      private var _itemList:Vector.<LuckRankItem>;
      
      private var _dataList:Vector.<Object>;
      
      public function TreasureRankView()
      {
         _dataList = new Vector.<Object>();
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var item:* = null;
         _rankBG = ComponentFactory.Instance.creat("treasureHunting.rankBG");
         addChild(_rankBG);
         _ranklist = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.LuckBox");
         addChild(_ranklist);
         _itemList = new Vector.<LuckRankItem>();
         for(i = 0; i < 10; )
         {
            item = new LuckRankItem(i);
            item.addEventListener("click",onItemClick);
            _ranklist.addChild(item);
            _itemList.push(item);
            i++;
         }
      }
      
      protected function onItemClick(event:MouseEvent) : void
      {
         var i:int = 0;
         for(i = 0; i <= _itemList.length - 1; )
         {
            (_itemList[i] as LuckRankItem).selected = false;
            i++;
         }
         (event.currentTarget as LuckRankItem).selected = true;
      }
      
      private function initEvent() : void
      {
         RouletteManager.instance.addEventListener("update_badLuck",__getLuckRank);
      }
      
      protected function __getLuckRank(event:CaddyEvent) : void
      {
         var i:int = 0;
         var obj:* = null;
         _dataList = event.dataList;
         i = 0;
         while(i < 10 && i < _dataList.length)
         {
            obj = _dataList[i];
            _itemList[i].update(i,obj["Nickname"],obj["Count"]);
            i++;
         }
      }
      
      private function removeEvent() : void
      {
         RouletteManager.instance.removeEventListener("update_badLuck",__getLuckRank);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_rankBG)
         {
            ObjectUtils.disposeObject(_rankBG);
         }
         _rankBG = null;
         if(_ranklist)
         {
            ObjectUtils.disposeObject(_ranklist);
         }
         _ranklist = null;
         _itemList = null;
         _dataList = null;
      }
   }
}
