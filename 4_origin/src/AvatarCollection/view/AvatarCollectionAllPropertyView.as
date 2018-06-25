package AvatarCollection.view
{
   import AvatarCollection.AvatarCollectionManager;
   import AvatarCollection.data.AvatarCollectionUnitVo;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import ddt.manager.TimeManager;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class AvatarCollectionAllPropertyView extends Sprite implements Disposeable
   {
       
      
      private var _allPropertyCellList:Vector.<AvatarCollectionPropertyCell>;
      
      public function AvatarCollectionAllPropertyView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var tmp:* = null;
         _allPropertyCellList = new Vector.<AvatarCollectionPropertyCell>();
         for(i = 0; i < 7; )
         {
            tmp = new AvatarCollectionPropertyCell(i);
            tmp.x = int(i / 4) * 110;
            tmp.y = i % 4 * 25;
            addChild(tmp);
            _allPropertyCellList.push(tmp);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         PlayerManager.Instance.addEventListener("updatePlayerState",__updatePlayerPropertyHandler);
      }
      
      private function __updatePlayerPropertyHandler(event:Event) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         var i:int = 0;
         var data:* = null;
         var addedPropertyArr:* = null;
         var totalCount:int = 0;
         var activityCount:int = 0;
         var endTime:* = null;
         var nowTimestamp:Number = NaN;
         var p:int = 0;
         var j:int = 0;
         var k:int = 0;
         var dataArr:Array = AvatarCollectionManager.instance.maleUnitList;
         dataArr = dataArr.concat(AvatarCollectionManager.instance.femaleUnitList);
         dataArr = dataArr.concat(AvatarCollectionManager.instance.weaponUnitList);
         var value:AvatarCollectionUnitVo = new AvatarCollectionUnitVo();
         var propertyArr:Array = [value.Attack,value.Defence,value.Agility,value.Luck,value.Damage,value.Guard,value.Blood];
         for(i = 0; i < dataArr.length; )
         {
            data = dataArr[i];
            addedPropertyArr = [data.Attack,data.Defence,data.Agility,data.Luck,data.Damage,data.Guard,data.Blood];
            totalCount = data.totalItemList.length;
            activityCount = data.totalActivityItemCount;
            endTime = data.endTime;
            nowTimestamp = TimeManager.Instance.Now().getTime();
            if(activityCount < totalCount / 2)
            {
               for(p = 0; p < propertyArr.length; )
               {
                  var _loc15_:* = p;
                  var _loc16_:* = propertyArr[_loc15_] + 0;
                  propertyArr[_loc15_] = _loc16_;
                  p++;
               }
            }
            else if(activityCount == totalCount)
            {
               for(j = 0; j < propertyArr.length; )
               {
                  _loc16_ = j;
                  _loc15_ = propertyArr[_loc16_] + addedPropertyArr[j] * 2;
                  propertyArr[_loc16_] = _loc15_;
                  j++;
               }
            }
            else
            {
               k = 0;
               while(k < propertyArr.length)
               {
                  _loc15_ = k;
                  _loc16_ = propertyArr[_loc15_] + addedPropertyArr[k];
                  propertyArr[_loc15_] = _loc16_;
                  k++;
               }
            }
            i++;
         }
         value.Attack = propertyArr[0];
         value.Defence = propertyArr[1];
         value.Agility = propertyArr[2];
         value.Luck = propertyArr[3];
         value.Damage = propertyArr[4];
         value.Guard = propertyArr[5];
         value.Blood = propertyArr[6];
         var _loc18_:int = 0;
         var _loc17_:* = _allPropertyCellList;
         for each(var tmp in _allPropertyCellList)
         {
            tmp.refreshAllProperty(value);
         }
      }
      
      private function removeEvent() : void
      {
         PlayerManager.Instance.removeEventListener("updatePlayerState",__updatePlayerPropertyHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _allPropertyCellList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
