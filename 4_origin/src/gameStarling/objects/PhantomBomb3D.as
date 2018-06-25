package gameStarling.objects
{
   import com.greensock.TweenLite;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Point;
   import gameCommon.model.Bomb;
   import gameCommon.model.Living;
   
   public class PhantomBomb3D extends SimpleBomb3D
   {
       
      
      private var _phantomCount:int;
      
      private var _currentBombActions:Array;
      
      private var _maxTime:Number = 0;
      
      private var _tweenVec:Array;
      
      public function PhantomBomb3D(info:Bomb, owner:Living, refineryLevel:int = 0)
      {
         var i:int = 0;
         var bombAction:* = null;
         _tweenVec = [];
         super(info,owner,refineryLevel);
         _currentBombActions = [];
         for(i = 0; i < _info.Actions.length; )
         {
            bombAction = _info.Actions[i] as BombAction3D;
            if(bombAction.type == 2 || bombAction.type == 4)
            {
               _maxTime = bombAction.time;
               _currentBombActions.push(bombAction);
            }
            else if(bombAction.type == 23)
            {
               _currentBombActions.push(bombAction);
            }
            i++;
         }
         if(_maxTime > 0)
         {
            _phantomCount = int((_maxTime - 2500) / 500);
         }
      }
      
      override public function moveTo(p:Point) : void
      {
         var newInfo:* = null;
         var simpleBomb:* = null;
         super.moveTo(p);
         if(_lifeTime % 80 == 0)
         {
            if(_phantomCount > 0)
            {
               newInfo = new Bomb();
               ObjectUtils.copyProperties(newInfo,_info);
               newInfo.Template = _info.Template;
               newInfo.Actions = _currentBombActions.concat();
               simpleBomb = new SimpleBomb3D(newInfo,_owner,_refineryLevel,true);
               simpleBomb.alpha = 0.2;
               this.map.addPhysical(simpleBomb);
               if(fastModel)
               {
                  simpleBomb.bombAtOnce();
               }
               changeAlphaPlay(simpleBomb,_maxTime);
            }
            _phantomCount = Number(_phantomCount) - 1;
         }
      }
      
      private function changeAlphaPlay(bomb:SimpleBomb3D, duration:Number) : void
      {
         TweenLite.to(bomb,duration / 1000,{"alpha":0.9});
         _tweenVec.push(bomb);
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         super.dispose();
         if(_tweenVec)
         {
            for(i = 0; i < _tweenVec.length; )
            {
               TweenLite.killTweensOf(_tweenVec[i]);
               i++;
            }
            _tweenVec = null;
         }
      }
   }
}
