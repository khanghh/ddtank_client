package gameStarling.objects
{
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   import gameStarling.view.map.MapView3D;
   import road7th.data.DictionaryData;
   import starlingPhy.maps.Map3D;
   
   public class TowBomb3D extends SimpleBomb3D
   {
       
      
      private var _tempAction:Array;
      
      private var _tempMap:Map3D;
      
      public function TowBomb3D(info:Bomb, owner:Living, refineryLevel:int = 0, isPhantom:Boolean = false)
      {
         initData(info);
         super(info,owner,refineryLevel,isPhantom);
      }
      
      private function initData(info:Bomb) : void
      {
         var i:int = 0;
         var tempAction:* = null;
         var arr1:Array = [];
         var arr2:Array = [];
         for(i = 0; i < info.Actions.length; )
         {
            tempAction = info.Actions[i] as BombAction3D;
            if(tempAction.type == 25 || tempAction.type == 26 || tempAction.type == 5 || tempAction.type == 29)
            {
               arr1.push(tempAction);
            }
            else
            {
               arr2.push(info.Actions[i]);
            }
            i++;
         }
         arr1.sort(actionSort);
         _tempAction = arr1;
         info.Actions = arr2;
      }
      
      private function actionSort(a:BombAction3D, b:BombAction3D) : int
      {
         if(a.time < b.time)
         {
            return -1;
         }
         if(a.time == b.time)
         {
            if(a.type == 23)
            {
               return -1;
            }
            if(a.type == 5)
            {
               return 1;
            }
            if(a.type == 25 || a.type == 26 || a.type == 5 || a.type == 29)
            {
               if(b.type == 26 || b.type == 25 || b.type == 5 || a.type == 29)
               {
                  if(a.param4 > b.param4)
                  {
                     return 1;
                  }
                  return -1;
               }
               return -1;
            }
         }
         return 1;
      }
      
      override public function setMap(map:Map3D) : void
      {
         super.setMap(map);
         if(map != null)
         {
            _tempMap = map;
         }
      }
      
      override protected function isPillarCollide() : Boolean
      {
         return true;
      }
      
      override public function bomb() : void
      {
         super.bomb();
         checkMonsterAction();
      }
      
      private function checkMonsterAction() : void
      {
         var i:int = 0;
         var action:* = null;
         var id:int = 0;
         var arr:* = null;
         var living:* = null;
         var dic:DictionaryData = new DictionaryData();
         for(i = 0; i < _tempAction.length; )
         {
            action = _tempAction[i] as BombAction3D;
            id = action.param1;
            if(!dic.hasKey(id))
            {
               dic.add(id,[]);
            }
            arr = dic[id];
            arr.push(action);
            i++;
         }
         var _loc9_:int = 0;
         var _loc8_:* = dic;
         for(var key in dic)
         {
            living = (_tempMap as MapView3D).getPhysical(key) as GameLiving3D;
            if(living)
            {
               living.startAction(dic[key]);
            }
         }
         dic.clear();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _tempAction = null;
      }
   }
}
