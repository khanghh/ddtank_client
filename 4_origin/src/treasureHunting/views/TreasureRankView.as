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
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _rankBG = ComponentFactory.Instance.creat("treasureHunting.rankBG");
         addChild(_rankBG);
         _ranklist = ComponentFactory.Instance.creatComponentByStylename("treasureHunting.LuckBox");
         addChild(_ranklist);
         _itemList = new Vector.<LuckRankItem>();
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new LuckRankItem(_loc2_);
            _loc1_.addEventListener("click",onItemClick);
            _ranklist.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      protected function onItemClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ <= _itemList.length - 1)
         {
            (_itemList[_loc2_] as LuckRankItem).selected = false;
            _loc2_++;
         }
         (param1.currentTarget as LuckRankItem).selected = true;
      }
      
      private function initEvent() : void
      {
         RouletteManager.instance.addEventListener("update_badLuck",__getLuckRank);
      }
      
      protected function __getLuckRank(param1:CaddyEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _dataList = param1.dataList;
         _loc3_ = 0;
         while(_loc3_ < 10 && _loc3_ < _dataList.length)
         {
            _loc2_ = _dataList[_loc3_];
            _itemList[_loc3_].update(_loc3_,_loc2_["Nickname"],_loc2_["Count"]);
            _loc3_++;
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
