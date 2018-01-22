package magpieBridge.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import ddtBuried.data.MapItemData;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import magpieBridge.MagpieBridgeManager;
   
   public class MagpieBridgeMap extends Sprite implements Disposeable
   {
      
      private static const ICON_WIDTH:int = 70;
       
      
      private var _mapArray:Array;
      
      private var _mapVec:Vector.<Sprite>;
      
      private var _light:MovieClip;
      
      public function MagpieBridgeMap()
      {
         _mapArray = [[1,1,1,1,4,4,3,3,4,4,4,4,1,1,1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,4,4,4,3,3,4],[1,1,2,2,1,1,1,1,1,1,1,1,4,4,4,4,4,4,3,3,3,3,3,3,2,2,2,2,1,1,1,1,4,4,3],[1,1,4,4,3,4,4,4,1,1,1,2,2,2,2,1,1,1,2,2,1,1,1,4,4,4,4,4,4,3,3,3,3,2,2]];
         super();
         this.rotationX = -35;
         this.scaleY = 0.6;
         _mapVec = new Vector.<Sprite>();
         initView();
      }
      
      private function initView() : void
      {
         creatMap();
         addProps();
      }
      
      private function creatMap() : void
      {
         var _loc5_:int = 0;
         var _loc1_:* = null;
         var _loc4_:* = null;
         var _loc3_:Array = _mapArray[MagpieBridgeManager.instance.magpieModel.MapId];
         var _loc6_:Bitmap = ComponentFactory.Instance.creat("asset.magpieMap.begin");
         var _loc2_:Sprite = new Sprite();
         _loc2_.addChild(_loc6_);
         addChild(_loc2_);
         _mapVec.push(_loc2_);
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc1_ = ComponentFactory.Instance.creat("asset.magpieMap.icon");
            _loc4_ = new Sprite();
            _loc4_.addChild(_loc1_);
            PositionUtils.setPos(_loc4_,getIconPos(_mapVec[_loc5_],_loc4_,_loc3_[_loc5_]));
            addChild(_loc4_);
            _mapVec.push(_loc4_);
            _loc5_++;
         }
      }
      
      private function addProps() : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc4_:Vector.<MapItemData> = MagpieBridgeManager.instance.magpieModel.MapDataVec;
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            if(_loc4_[_loc6_].tempID <= 0 && _loc4_[_loc6_].tempID >= -5)
            {
               _loc5_ = ComponentFactory.Instance.creat("asset.magpieMap.props" + _loc4_[_loc6_].tempID.toString());
               _loc5_.x = (_mapVec[_loc4_[_loc6_].type].width - _loc5_.width) / 2;
               _loc5_.y = (_mapVec[_loc4_[_loc6_].type].height - _loc5_.height) / 2;
               _mapVec[_loc4_[_loc6_].type].addChild(_loc5_);
            }
            else if(_loc4_[_loc6_].tempID == -6)
            {
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("magpieBridge.magpieMap.magpieImage");
               _loc2_.tipData = LanguageMgr.GetTranslation("magpieBridgeView.magpie.tipsTxt");
               _mapVec[_loc4_[_loc6_].type].addChild(_loc2_);
            }
            else
            {
               _loc3_ = ItemManager.Instance.getTemplateById(_loc4_[_loc6_].tempID);
               _loc1_ = new BagCell(0,_loc3_);
               _loc1_.setBgVisible(false);
               _loc1_.width = _mapVec[_loc4_[_loc6_].type].width;
               _loc1_.height = _mapVec[_loc4_[_loc6_].type].height;
               _loc1_.x = 4;
               _loc1_.y = 6;
               _mapVec[_loc4_[_loc6_].type].addChild(_loc1_);
            }
            _loc6_++;
         }
         _light = ComponentFactory.Instance.creat("asset.magpieBridge.overLight");
         _mapVec[_mapVec.length - 1].addChildAt(_light,0);
      }
      
      public function closeIcon() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = MagpieBridgeManager.instance.magpieModel.NowPosition;
         if(_loc1_ < _mapVec.length - 1 && _mapVec[_loc1_].numChildren >= 2)
         {
            _mapVec[_loc1_].removeChildAt(1);
            _loc2_ = ComponentFactory.Instance.creat("asset.magpieMap.props0");
            _loc2_.x = (_mapVec[_loc1_].width - _loc2_.width) / 2;
            _loc2_.y = (_mapVec[_loc1_].height - _loc2_.height) / 2;
            _mapVec[_loc1_].addChild(_loc2_);
         }
      }
      
      private function getIconPos(param1:Sprite, param2:Sprite, param3:int) : Point
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(param3 == 1)
         {
            _loc5_ = param1.x - 70;
            _loc4_ = param1.y + (param1.height - param2.height) / 2;
         }
         else if(param3 == 2)
         {
            _loc5_ = param1.x;
            _loc4_ = param1.y - 70;
         }
         else if(param3 == 3)
         {
            _loc5_ = param1.x + 70;
            _loc4_ = param1.y + (param1.height - param2.height) / 2;
         }
         else if(param3 == 4)
         {
            _loc5_ = param1.x;
            _loc4_ = param1.y + 70;
         }
         return new Point(_loc5_,_loc4_);
      }
      
      public function dispose() : void
      {
         ObjectUtils.removeChildAllChildren(this);
      }
      
      public function get mapVec() : Vector.<Sprite>
      {
         return _mapVec;
      }
   }
}
