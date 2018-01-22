package beadSystem.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import road7th.data.DictionaryData;
   import store.view.embed.EmbedStoneCell;
   
   public class PlayerBeadInfoView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _beadCells:DictionaryData;
      
      private var _HoleOpen:DictionaryData;
      
      private var _pointArray:Vector.<Point>;
      
      private var _playerInfo:PlayerInfo;
      
      public function PlayerBeadInfoView()
      {
         super();
         _HoleOpen = new DictionaryData();
         _beadCells = new DictionaryData();
         getCellsPoint();
         initView();
      }
      
      private function initView() : void
      {
         var _loc10_:int = 0;
         var _loc7_:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("beadSystem.playerBeadInfo.bg");
         addChild(_bg);
         var _loc8_:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[1,1]);
         _loc8_.x = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint1")).x;
         _loc8_.y = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint1")).y;
         _loc8_.StoneType = 1;
         addChild(_loc8_);
         _beadCells.add(1,_loc8_);
         var _loc11_:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[2,2]);
         _loc11_.x = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint2")).x;
         _loc11_.y = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint2")).y;
         _loc11_.StoneType = 2;
         addChild(_loc11_);
         _beadCells.add(2,_loc11_);
         var _loc9_:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[3,2]);
         _loc9_.x = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint3")).x;
         _loc9_.y = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint3")).y;
         _loc9_.StoneType = 2;
         addChild(_loc9_);
         _beadCells.add(3,_loc9_);
         _loc10_ = 4;
         while(_loc10_ <= 12)
         {
            _loc7_ = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[_loc10_,3]);
            _loc7_.StoneType = 3;
            _loc7_.x = _pointArray[_loc10_ - 1].x;
            _loc7_.y = _pointArray[_loc10_ - 1].y;
            addChild(_loc7_);
            _beadCells.add(_loc10_,_loc7_);
            _loc10_++;
         }
         var _loc3_:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[13,3]);
         _loc3_.x = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint13")).x;
         _loc3_.y = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint13")).y;
         _loc3_.StoneType = 3;
         addChild(_loc3_);
         _beadCells.add(13,_loc3_);
         _HoleOpen.add(13,_loc3_);
         var _loc4_:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[14,3]);
         _loc4_.x = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint14")).x;
         _loc4_.y = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint14")).y;
         _loc4_.StoneType = 3;
         addChild(_loc4_);
         _beadCells.add(14,_loc4_);
         _HoleOpen.add(14,_loc4_);
         var _loc1_:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[15,3]);
         _loc1_.x = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint15")).x;
         _loc1_.y = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint15")).y;
         _loc1_.StoneType = 3;
         addChild(_loc1_);
         _beadCells.add(15,_loc1_);
         _HoleOpen.add(15,_loc1_);
         var _loc2_:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[16,3]);
         _loc2_.x = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint16")).x;
         _loc2_.y = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint16")).y;
         _loc2_.StoneType = 3;
         addChild(_loc2_);
         _beadCells.add(16,_loc2_);
         _HoleOpen.add(16,_loc2_);
         var _loc6_:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[17,3]);
         _loc6_.x = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint17")).x;
         _loc6_.y = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint17")).y;
         _loc6_.StoneType = 3;
         addChild(_loc6_);
         _beadCells.add(17,_loc6_);
         _HoleOpen.add(17,_loc6_);
         var _loc5_:EmbedStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreEmbedBG.EmbedStoneCell",[18,3]);
         _loc5_.x = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint18")).x;
         _loc5_.y = Point(ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint18")).y;
         _loc5_.StoneType = 3;
         addChild(_loc5_);
         _beadCells.add(18,_loc5_);
         _HoleOpen.add(18,_loc5_);
      }
      
      private function getCellsPoint() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _pointArray = new Vector.<Point>();
         _loc2_ = 1;
         while(_loc2_ <= 18)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("bead.PlayerEmbedpoint" + _loc2_);
            _pointArray.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function set playerInfo(param1:PlayerInfo) : void
      {
         _playerInfo = param1;
         if(param1)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _beadCells;
            for each(var _loc3_ in _beadCells)
            {
               _loc3_.info = null;
            }
            var _loc7_:int = 0;
            var _loc6_:* = _beadCells;
            for each(var _loc2_ in _beadCells)
            {
               _loc2_.otherPlayer = param1;
               _loc2_.itemInfo = param1.BeadBag.getItemAt(_loc2_.ID);
               _loc2_.info = param1.BeadBag.getItemAt(_loc2_.ID);
               if(_loc2_.ID >= 13 && param1.BeadBag.getItemAt(_loc2_.ID))
               {
                  _loc2_.open();
               }
            }
         }
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         var _loc3_:int = 0;
         var _loc2_:* = _beadCells;
         for each(var _loc1_ in _beadCells)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
