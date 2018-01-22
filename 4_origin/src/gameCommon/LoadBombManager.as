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
      
      public static const SpecialAllBomb:Array = [1,3,4,64,59,97,98,120,10619];
      
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
      
      public function loadFullRoomPlayersBomb(param1:Array) : void
      {
         loadFullWeaponBombMovie(param1);
         loadFullWeaponBombBitMap(param1);
      }
      
      private function loadFullWeaponBombMovie(param1:Array) : void
      {
         var _loc4_:int = 0;
         _tempWeaponInfos = null;
         _tempWeaponInfos = new Dictionary();
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(var _loc2_ in param1)
         {
            if(!_loc2_.isViewer)
            {
               _loc4_ = _loc2_.playerInfo.WeaponID > 0?_loc2_.currentWeapInfo.TemplateID:70016;
               if(!_tempWeaponInfos[_loc4_])
               {
                  _tempWeaponInfos[_loc4_] = new WeaponInfo(ItemManager.Instance.getTemplateById(_loc4_));
               }
            }
         }
         if(!StartupResourceLoader.firstEnterHall)
         {
            var _loc8_:int = 0;
            var _loc7_:* = _tempWeaponInfos;
            for each(var _loc3_ in _tempWeaponInfos)
            {
               loadBomb(_loc3_);
            }
         }
      }
      
      private function loadFullWeaponBombBitMap(param1:Array) : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         _tempCraterIDs = null;
         _tempCraterIDs = new Dictionary();
         var _loc7_:int = 0;
         var _loc6_:* = _tempWeaponInfos;
         for each(var _loc2_ in _tempWeaponInfos)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc2_.bombs.length)
            {
               _loc3_ = _loc2_.bombs[_loc5_];
               if(TwoBomb.hasOwnProperty(_loc3_))
               {
                  if(!_tempCraterIDs[BallManager.instance.findBall(TwoBomb[_loc3_]).craterID])
                  {
                     _tempCraterIDs[BallManager.instance.findBall(TwoBomb[_loc3_]).craterID] = BallManager.instance.findBall(TwoBomb[_loc3_]);
                  }
               }
               if(!_tempCraterIDs[BallManager.instance.findBall(_loc2_.bombs[_loc5_]).craterID])
               {
                  _tempCraterIDs[BallManager.instance.findBall(_loc2_.bombs[_loc5_]).craterID] = BallManager.instance.findBall(_loc2_.bombs[_loc5_]);
               }
               _loc5_++;
            }
         }
         var _loc9_:int = 0;
         var _loc8_:* = _tempCraterIDs;
         for each(var _loc4_ in _tempCraterIDs)
         {
            _loc4_.loadCraterBitmap();
         }
      }
      
      private function loadBomb(param1:WeaponInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.bombs.length)
         {
            BallManager.instance.findBall(param1.bombs[_loc3_]).loadBombAsset();
            _loc2_ = param1.bombs[_loc3_];
            if(TwoBomb.hasOwnProperty(_loc2_))
            {
               BallManager.instance.findBall(TwoBomb[_loc2_]).loadBombAsset();
            }
            BallManager.instance.findBall(_loc2_).loadBombAsset();
            _loc3_++;
         }
      }
      
      public function getLoadBombComplete(param1:WeaponInfo) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.bombs.length)
         {
            _loc2_ = param1.bombs[_loc3_];
            if(TwoBomb.hasOwnProperty(_loc2_))
            {
               if(!BallManager.instance.findBall(TwoBomb[_loc2_]).isComplete())
               {
                  return false;
               }
            }
            if(!BallManager.instance.findBall(_loc2_).isComplete())
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public function getUnloadedBombString(param1:WeaponInfo) : String
      {
         var _loc3_:int = 0;
         var _loc2_:String = "";
         _loc3_ = 0;
         while(_loc3_ < param1.bombs.length)
         {
            if(!BallManager.instance.findBall(param1.bombs[_loc3_]).isComplete())
            {
               _loc2_ = _loc2_ + (param1.bombs[_loc3_] + ",");
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function loadLivingBomb(param1:int) : void
      {
         try
         {
            BallManager.instance.findBall(param1).loadBombAsset();
            BallManager.instance.findBall(param1).loadCraterBitmap();
            return;
         }
         catch(e:Error)
         {
            throw new Error("刘雯静你的意大利炮" + param1.toString() + "呢?");
         }
      }
      
      public function getLivingBombComplete(param1:int) : Boolean
      {
         return BallManager.instance.findBall(param1).isComplete();
      }
      
      public function loadSpecialBomb() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < SpecialAllBomb.length)
         {
            BallManager.instance.findBall(SpecialAllBomb[_loc1_]).loadBombAsset();
            BallManager.instance.findBall(SpecialAllBomb[_loc1_]).loadCraterBitmap();
            _loc1_++;
         }
      }
      
      public function loadSceneEffectBomb() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < SceneEffectBomb.length)
         {
            _loc1_ = BallManager.instance.findBall(SceneEffectBomb[_loc2_]);
            _loc1_.loadBombAsset();
            _loc1_.loadCraterBitmap();
            _loc2_++;
         }
      }
      
      public function getUnloadedSpecialBombString() : String
      {
         var _loc2_:int = 0;
         var _loc1_:String = "";
         _loc2_ = 0;
         while(_loc2_ < SpecialAllBomb.length)
         {
            if(!BallManager.instance.findBall(SpecialAllBomb[_loc2_]).isComplete())
            {
               _loc1_ = _loc1_ + (SpecialAllBomb[_loc2_] + ",");
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getLoadSpecialBombComplete() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < SpecialAllBomb.length)
         {
            if(!BallManager.instance.findBall(SpecialAllBomb[_loc1_]).isComplete())
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      public function loadOutBomb(param1:Array) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            if(!hasLoadWeaponBomb(param1[_loc2_]))
            {
               BallManager.instance.findBall(param1[_loc2_]).loadCraterBitmap();
            }
            _loc2_++;
         }
      }
      
      private function hasLoadWeaponBomb(param1:int) : Boolean
      {
         if(_tempCraterIDs == null)
         {
            return false;
         }
         var _loc4_:int = 0;
         var _loc3_:* = _tempCraterIDs;
         for each(var _loc2_ in _tempCraterIDs)
         {
            if(_loc2_.ID == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function loadFullRoomPlayersBomb3D(param1:Array) : void
      {
         loadFullWeaponBombMovie3D(param1);
         loadFullWeaponBombBitMap(param1);
      }
      
      private function loadFullWeaponBombMovie3D(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         _tempWeaponInfos = null;
         _tempWeaponInfos = new Dictionary();
         var _loc8_:int = 0;
         var _loc7_:* = param1;
         for each(var _loc2_ in param1)
         {
            if(!_loc2_.isViewer)
            {
               _loc4_ = _loc2_.playerInfo.WeaponID > 0?_loc2_.currentWeapInfo.TemplateID:70016;
               if(!_tempWeaponInfos[_loc4_])
               {
                  _loc6_ = new WeaponInfo(ItemManager.Instance.getTemplateById(_loc4_));
                  _tempWeaponInfos[_loc4_] = _loc6_;
                  _loc5_ = _loc6_.bombs[0];
                  if(TwoBomb.hasOwnProperty(_loc5_))
                  {
                     BallManager.instance.findBall(TwoBomb[_loc5_]).loadBombAsset3D();
                  }
               }
               if(!StartupResourceLoader.firstEnterHall && _loc2_.playerInfo.DeputyWeaponID > 0)
               {
                  _loc6_ = new WeaponInfo(ItemManager.Instance.getTemplateById(_loc2_.playerInfo.DeputyWeaponID));
                  if(_loc6_.bombs && _loc6_.bombs.length && !_tempWeaponInfos[_loc6_.bombs[0]] && SpecialAllBomb.indexOf(_loc6_.bombs[0]) != -1)
                  {
                     _tempWeaponInfos[_loc6_.bombs[0]] = _loc6_;
                  }
               }
            }
         }
         if(!StartupResourceLoader.firstEnterHall)
         {
            var _loc10_:int = 0;
            var _loc9_:* = _tempWeaponInfos;
            for each(var _loc3_ in _tempWeaponInfos)
            {
               if(_loc3_.bombs.length)
               {
                  loadLivingBomb3D(_loc3_.bombs[0]);
               }
            }
         }
      }
      
      public function loadLivingBomb3D(param1:int) : void
      {
         BallManager.instance.findBall(param1).loadBombAsset3D();
         BallManager.instance.findBall(param1).loadCraterBitmap();
      }
      
      public function getLivingBombComplete3D(param1:int) : Boolean
      {
         return BallManager.instance.findBall(param1).isComplete3D();
      }
      
      public function loadSpecialBomb3D() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < SpecialBomb.length)
         {
            BallManager.instance.findBall(SpecialBomb[_loc1_]).loadBombAsset3D();
            BallManager.instance.findBall(SpecialBomb[_loc1_]).loadCraterBitmap();
            _loc1_++;
         }
      }
      
      public function loadOutBomb3D(param1:Array) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            if(!hasLoadWeaponBomb(param1[_loc2_]))
            {
               BallManager.instance.findBall(param1[_loc2_]).loadCraterBitmap();
            }
            _loc2_++;
         }
      }
      
      public function loadSceneEffectBomb3D() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < SceneEffectBomb.length)
         {
            _loc1_ = BallManager.instance.findBall(SceneEffectBomb[_loc2_]);
            _loc1_.loadBombAsset3D();
            _loc1_.loadCraterBitmap();
            _loc2_++;
         }
      }
      
      public function getLoadBombComplete3D(param1:WeaponInfo) : Boolean
      {
         var _loc2_:int = 0;
         if(param1.bombs.length > 0)
         {
            if(!BallManager.instance.findBall(param1.bombs[0]).isComplete3D())
            {
               return false;
            }
            _loc2_ = param1.bombs[0];
            if(TwoBomb.hasOwnProperty(_loc2_))
            {
               if(!BallManager.instance.findBall(TwoBomb[_loc2_]).isComplete3D())
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public function getLoadSpecialBombComplete3D() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < SpecialBomb.length)
         {
            if(!BallManager.instance.findBall(SpecialBomb[_loc1_]).isComplete3D())
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      public function getUnloadedSpecialBomb3DString() : String
      {
         var _loc2_:int = 0;
         var _loc1_:String = "";
         _loc2_ = 0;
         while(_loc2_ < SpecialBomb.length)
         {
            if(!BallManager.instance.findBall(SpecialBomb[_loc2_]).isComplete())
            {
               _loc1_ = _loc1_ + (SpecialBomb[_loc2_] + ",");
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getLoadSceneEffectBombComplete3D() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < SceneEffectBomb.length)
         {
            if(!BallManager.instance.findBall(SceneEffectBomb[_loc1_]).isComplete3D())
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
   }
}
