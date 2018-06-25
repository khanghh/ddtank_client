package gameCommon
{
   import ddt.data.BallInfo;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.BallManager;
   import ddt.manager.ItemManager;
   import flash.utils.Dictionary;
   import room.model.RoomPlayer;
   import room.model.WeaponInfo;
   
   public class LoadBombManager
   {
      
      public static const SpecialBomb:Array = [1,3,4];
      
      public static const SpecialAllBomb:Array = [1,3,4,64,59,97,98,120,189,10619];
      
      public static const SceneEffectBomb:Array = [107,130,147,149];
      
      public static const TwoBomb:Object = {
         11245:11241,
         112451:112411,
         112452:112412,
         11246:11242
      };
      
      private static var _instance:LoadBombManager;
       
      
      private var _tempWeaponInfos:Dictionary;
      
      private var _tempCraterIDs:Dictionary;
      
      public function LoadBombManager()
      {
         super();
      }
      
      public static function get Instance() : LoadBombManager
      {
         if(_instance == null)
         {
            _instance = new LoadBombManager();
         }
         return _instance;
      }
      
      public function loadFullRoomPlayersBomb(roomPlayers:Array) : void
      {
         loadFullWeaponBombMovie(roomPlayers);
         loadFullWeaponBombBitMap(roomPlayers);
      }
      
      private function loadFullWeaponBombMovie(roomPlayers:Array) : void
      {
         var weaponID:int = 0;
         _tempWeaponInfos = null;
         _tempWeaponInfos = new Dictionary();
         var _loc6_:int = 0;
         var _loc5_:* = roomPlayers;
         for each(var player in roomPlayers)
         {
            if(!player.isViewer)
            {
               weaponID = player.playerInfo.WeaponID > 0?player.currentWeapInfo.TemplateID:70016;
               if(!_tempWeaponInfos[weaponID])
               {
                  _tempWeaponInfos[weaponID] = new WeaponInfo(ItemManager.Instance.getTemplateById(weaponID));
               }
            }
         }
         if(!StartupResourceLoader.firstEnterHall)
         {
            var _loc8_:int = 0;
            var _loc7_:* = _tempWeaponInfos;
            for each(var weapInfo in _tempWeaponInfos)
            {
               loadBomb(weapInfo);
            }
         }
      }
      
      private function loadFullWeaponBombBitMap(roomPlayers:Array) : void
      {
         var i:int = 0;
         var bombId:int = 0;
         _tempCraterIDs = null;
         _tempCraterIDs = new Dictionary();
         var _loc7_:int = 0;
         var _loc6_:* = _tempWeaponInfos;
         for each(var weapInfo in _tempWeaponInfos)
         {
            for(i = 0; i < weapInfo.bombs.length; )
            {
               bombId = weapInfo.bombs[i];
               if(TwoBomb.hasOwnProperty(bombId))
               {
                  if(!_tempCraterIDs[BallManager.instance.findBall(TwoBomb[bombId]).craterID])
                  {
                     _tempCraterIDs[BallManager.instance.findBall(TwoBomb[bombId]).craterID] = BallManager.instance.findBall(TwoBomb[bombId]);
                  }
               }
               if(!_tempCraterIDs[BallManager.instance.findBall(weapInfo.bombs[i]).craterID])
               {
                  _tempCraterIDs[BallManager.instance.findBall(weapInfo.bombs[i]).craterID] = BallManager.instance.findBall(weapInfo.bombs[i]);
               }
               i++;
            }
         }
         var _loc9_:int = 0;
         var _loc8_:* = _tempCraterIDs;
         for each(var ballInfo in _tempCraterIDs)
         {
            ballInfo.loadCraterBitmap();
         }
      }
      
      private function loadBomb(info:WeaponInfo) : void
      {
         var i:int = 0;
         var bombId:int = 0;
         for(i = 0; i < info.bombs.length; )
         {
            BallManager.instance.findBall(info.bombs[i]).loadBombAsset();
            bombId = info.bombs[i];
            if(TwoBomb.hasOwnProperty(bombId))
            {
               BallManager.instance.findBall(TwoBomb[bombId]).loadBombAsset();
            }
            BallManager.instance.findBall(bombId).loadBombAsset();
            i++;
         }
      }
      
      public function getLoadBombComplete(info:WeaponInfo) : Boolean
      {
         var i:int = 0;
         var bombId:int = 0;
         for(i = 0; i < info.bombs.length; )
         {
            bombId = info.bombs[i];
            if(TwoBomb.hasOwnProperty(bombId))
            {
               if(!BallManager.instance.findBall(TwoBomb[bombId]).isComplete())
               {
                  return false;
               }
            }
            if(!BallManager.instance.findBall(bombId).isComplete())
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      public function getUnloadedBombString(info:WeaponInfo) : String
      {
         var i:int = 0;
         var result:String = "";
         for(i = 0; i < info.bombs.length; )
         {
            if(!BallManager.instance.findBall(info.bombs[i]).isComplete())
            {
               result = result + (info.bombs[i] + ",");
            }
            i++;
         }
         return result;
      }
      
      public function loadLivingBomb(id:int) : void
      {
         try
         {
            BallManager.instance.findBall(id).loadBombAsset();
            BallManager.instance.findBall(id).loadCraterBitmap();
            return;
         }
         catch(e:Error)
         {
            throw new Error("刘雯静你的意大利炮" + id.toString() + "呢?");
         }
      }
      
      public function getLivingBombComplete(id:int) : Boolean
      {
         return BallManager.instance.findBall(id).isComplete();
      }
      
      public function loadSpecialBomb() : void
      {
         var i:int = 0;
         for(i = 0; i < SpecialAllBomb.length; )
         {
            BallManager.instance.findBall(SpecialAllBomb[i]).loadBombAsset();
            BallManager.instance.findBall(SpecialAllBomb[i]).loadCraterBitmap();
            i++;
         }
      }
      
      public function loadSceneEffectBomb() : void
      {
         var i:int = 0;
         var ball:* = null;
         for(i = 0; i < SceneEffectBomb.length; )
         {
            ball = BallManager.instance.findBall(SceneEffectBomb[i]);
            ball.loadBombAsset();
            ball.loadCraterBitmap();
            i++;
         }
      }
      
      public function getUnloadedSpecialBombString() : String
      {
         var i:int = 0;
         var result:String = "";
         for(i = 0; i < SpecialAllBomb.length; )
         {
            if(!BallManager.instance.findBall(SpecialAllBomb[i]).isComplete())
            {
               result = result + (SpecialAllBomb[i] + ",");
            }
            i++;
         }
         return result;
      }
      
      public function getLoadSpecialBombComplete() : Boolean
      {
         var i:int = 0;
         for(i = 0; i < SpecialAllBomb.length; )
         {
            if(!BallManager.instance.findBall(SpecialAllBomb[i]).isComplete())
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      public function loadOutBomb(list:Array) : void
      {
         var i:int = 0;
         for(i = 0; i < list.length; )
         {
            if(!hasLoadWeaponBomb(list[i]))
            {
               BallManager.instance.findBall(list[i]).loadCraterBitmap();
            }
            i++;
         }
      }
      
      private function hasLoadWeaponBomb(id:int) : Boolean
      {
         if(_tempCraterIDs == null)
         {
            return false;
         }
         var _loc4_:int = 0;
         var _loc3_:* = _tempCraterIDs;
         for each(var info in _tempCraterIDs)
         {
            if(info.ID == id)
            {
               return true;
            }
         }
         return false;
      }
      
      public function loadFullRoomPlayersBomb3D(roomPlayers:Array) : void
      {
         loadFullWeaponBombMovie3D(roomPlayers);
         loadFullWeaponBombBitMap(roomPlayers);
      }
      
      private function loadFullWeaponBombMovie3D(roomPlayers:Array) : void
      {
         var weaponID:int = 0;
         var weaponInfo:* = null;
         var bombId:int = 0;
         _tempWeaponInfos = null;
         _tempWeaponInfos = new Dictionary();
         var _loc8_:int = 0;
         var _loc7_:* = roomPlayers;
         for each(var player in roomPlayers)
         {
            if(!player.isViewer)
            {
               weaponID = player.playerInfo.WeaponID > 0?player.currentWeapInfo.TemplateID:70016;
               if(!_tempWeaponInfos[weaponID])
               {
                  weaponInfo = new WeaponInfo(ItemManager.Instance.getTemplateById(weaponID));
                  _tempWeaponInfos[weaponID] = weaponInfo;
                  bombId = weaponInfo.bombs[0];
                  if(TwoBomb.hasOwnProperty(bombId))
                  {
                     BallManager.instance.findBall(TwoBomb[bombId]).loadBombAsset3D();
                  }
               }
               if(!StartupResourceLoader.firstEnterHall && player.playerInfo.DeputyWeaponID > 0)
               {
                  weaponInfo = new WeaponInfo(ItemManager.Instance.getTemplateById(player.playerInfo.DeputyWeaponID));
                  if(weaponInfo.bombs && weaponInfo.bombs.length && !_tempWeaponInfos[weaponInfo.bombs[0]] && SpecialAllBomb.indexOf(weaponInfo.bombs[0]) != -1)
                  {
                     _tempWeaponInfos[weaponInfo.bombs[0]] = weaponInfo;
                  }
               }
            }
         }
         if(!StartupResourceLoader.firstEnterHall)
         {
            var _loc10_:int = 0;
            var _loc9_:* = _tempWeaponInfos;
            for each(var weapInfo in _tempWeaponInfos)
            {
               if(weapInfo.bombs.length)
               {
                  loadLivingBomb3D(weapInfo.bombs[0]);
               }
            }
         }
      }
      
      public function loadLivingBomb3D(id:int) : void
      {
         BallManager.instance.findBall(id).loadBombAsset3D();
         BallManager.instance.findBall(id).loadCraterBitmap();
      }
      
      public function getLivingBombComplete3D(id:int) : Boolean
      {
         return BallManager.instance.findBall(id).isComplete3D();
      }
      
      public function loadSpecialBomb3D() : void
      {
         var i:int = 0;
         for(i = 0; i < SpecialBomb.length; )
         {
            BallManager.instance.findBall(SpecialBomb[i]).loadBombAsset3D();
            BallManager.instance.findBall(SpecialBomb[i]).loadCraterBitmap();
            i++;
         }
      }
      
      public function loadOutBomb3D(list:Array) : void
      {
         var i:int = 0;
         for(i = 0; i < list.length; )
         {
            if(!hasLoadWeaponBomb(list[i]))
            {
               BallManager.instance.findBall(list[i]).loadCraterBitmap();
            }
            i++;
         }
      }
      
      public function loadSceneEffectBomb3D() : void
      {
         var i:int = 0;
         var ball:* = null;
         for(i = 0; i < SceneEffectBomb.length; )
         {
            ball = BallManager.instance.findBall(SceneEffectBomb[i]);
            ball.loadBombAsset3D();
            ball.loadCraterBitmap();
            i++;
         }
      }
      
      public function getLoadBombComplete3D(info:WeaponInfo) : Boolean
      {
         var bombId:int = 0;
         if(info.bombs.length > 0)
         {
            if(!BallManager.instance.findBall(info.bombs[0]).isComplete3D())
            {
               return false;
            }
            bombId = info.bombs[0];
            if(TwoBomb.hasOwnProperty(bombId))
            {
               if(!BallManager.instance.findBall(TwoBomb[bombId]).isComplete3D())
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public function getLoadSpecialBombComplete3D() : Boolean
      {
         var i:int = 0;
         for(i = 0; i < SpecialBomb.length; )
         {
            if(!BallManager.instance.findBall(SpecialBomb[i]).isComplete3D())
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      public function getUnloadedSpecialBomb3DString() : String
      {
         var i:int = 0;
         var result:String = "";
         for(i = 0; i < SpecialBomb.length; )
         {
            if(!BallManager.instance.findBall(SpecialBomb[i]).isComplete())
            {
               result = result + (SpecialBomb[i] + ",");
            }
            i++;
         }
         return result;
      }
      
      public function getLoadSceneEffectBombComplete3D() : Boolean
      {
         var i:int = 0;
         for(i = 0; i < SceneEffectBomb.length; )
         {
            if(!BallManager.instance.findBall(SceneEffectBomb[i]).isComplete3D())
            {
               return false;
            }
            i++;
         }
         return true;
      }
   }
}
