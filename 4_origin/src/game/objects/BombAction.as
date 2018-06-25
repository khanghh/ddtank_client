package game.objects
{
   import ddt.manager.SocketManager;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.Player;
   import gameCommon.objects.ActionType;
   import phy.object.PhysicalObj;
   import room.RoomManager;
   
   public class BombAction
   {
       
      
      private var _time:int;
      
      private var _type:int;
      
      public var _param1:int;
      
      public var _param2:int;
      
      public var _param3:int;
      
      public var _param4:int;
      
      public function BombAction(time:int, type:int, param1:int, param2:int, param3:int, param4:int)
      {
         super();
         _time = time;
         _type = type;
         _param1 = param1;
         _param2 = param2;
         _param3 = param3;
         _param4 = param4;
      }
      
      public function get param1() : int
      {
         return _param1;
      }
      
      public function get param2() : int
      {
         return _param2;
      }
      
      public function get param3() : int
      {
         return _param3;
      }
      
      public function get param4() : int
      {
         return _param4;
      }
      
      public function get time() : int
      {
         return _time;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function execute(ball:SimpleBomb, _game:GameInfo) : void
      {
         ball = ball;
         _game = _game;
         var _loc4_:* = _type;
         if(1 !== _loc4_)
         {
            if(2 !== _loc4_)
            {
               if(3 !== _loc4_)
               {
                  if(4 !== _loc4_)
                  {
                     if(5 !== _loc4_)
                     {
                        if(6 !== _loc4_)
                        {
                           if(7 !== _loc4_)
                           {
                              if(8 !== _loc4_)
                              {
                                 if(9 !== _loc4_)
                                 {
                                    if(10 !== _loc4_)
                                    {
                                       if(11 !== _loc4_)
                                       {
                                          if(12 !== _loc4_)
                                          {
                                             if(13 !== _loc4_)
                                             {
                                                if(14 !== _loc4_)
                                                {
                                                   if(15 !== _loc4_)
                                                   {
                                                      if(17 !== _loc4_)
                                                      {
                                                         if(18 !== _loc4_)
                                                         {
                                                            if(19 !== _loc4_)
                                                            {
                                                               if(20 !== _loc4_)
                                                               {
                                                                  if(21 !== _loc4_)
                                                                  {
                                                                     if(22 !== _loc4_)
                                                                     {
                                                                        if(23 !== _loc4_)
                                                                        {
                                                                           if(24 !== _loc4_)
                                                                           {
                                                                              if(25 !== _loc4_)
                                                                              {
                                                                                 if(26 !== _loc4_)
                                                                                 {
                                                                                    if(29 === _loc4_)
                                                                                    {
                                                                                       var fallingDie1:Living = _game.findLiving(_param1);
                                                                                       var fallingDie2:PhysicalObj = ball.map.getPhysical(_param1);
                                                                                       if(fallingDie1 || fallingDie2 is GameLiving)
                                                                                       {
                                                                                          var params3:Array = [1,new Point(_param2,_param3),fallingInfo1.direction,false];
                                                                                          (fallingDie2 as GameLiving).playerMoveTo(params3);
                                                                                       }
                                                                                    }
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    var fallingInfo1:Living = _game.findLiving(_param1);
                                                                                    var fallingInfo2:PhysicalObj = ball.map.getPhysical(_param1);
                                                                                    if(fallingInfo1 || fallingInfo2 is GameLiving)
                                                                                    {
                                                                                       var params2:Array = [1,new Point(_param2,_param3),fallingInfo1.direction,true];
                                                                                       (fallingInfo2 as GameLiving).playerMoveTo(params2);
                                                                                    }
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 var moveInfo1:PhysicalObj = ball.map.getPhysical(_param1);
                                                                                 if(moveInfo1 is GameLiving)
                                                                                 {
                                                                                    (moveInfo1 as GameLiving).setProperty("speedMult","8");
                                                                                 }
                                                                                 var moveInfo2:Living = _game.findLiving(_param1);
                                                                                 if(moveInfo2)
                                                                                 {
                                                                                    if(_param2 > moveInfo2.pos.x)
                                                                                    {
                                                                                       moveInfo2.direction = 1;
                                                                                    }
                                                                                    else if(_param2 < moveInfo2.pos.x)
                                                                                    {
                                                                                       moveInfo2.direction = -1;
                                                                                    }
                                                                                    var backFun:Function = function():void
                                                                                    {
                                                                                       (moveInfo1 as GameLiving).setProperty("speedMult","1");
                                                                                    };
                                                                                    var params1:Array = [4,new Point(_param2,_param3),moveInfo2.direction,true,null,backFun];
                                                                                    (moveInfo1 as GameLiving).playerMoveTo(params1);
                                                                                 }
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              ball.pos = new Point(_param1,_param2);
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           ball.pos = new Point(_param1,_param2);
                                                                           ball.changeSpeedXY(_param3,_param4);
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        ball.pos = new Point(_param1,_param2);
                                                                        ball.changeSpeedXY(_param3,_param4);
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     ball.die();
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  var player10:Player = Player(_game.findLiving(_param1));
                                                                  if(player10 && RoomManager.Instance.current.type != 21 && RoomManager.Instance.current.type != 151)
                                                                  {
                                                                     var beatInfo:Dictionary = player10.currentPet.petBeatInfo;
                                                                     player10.petBeat(String(beatInfo["actionName"]),Point(beatInfo["targetPoint"]),beatInfo["targets"]);
                                                                  }
                                                               }
                                                            }
                                                            else
                                                            {
                                                               var player9:Living = _game.findLiving(_param1);
                                                               if(player9)
                                                               {
                                                                  player9.showAttackEffect(19);
                                                               }
                                                            }
                                                         }
                                                         else
                                                         {
                                                            var player8:Living = _game.findLiving(_param1);
                                                            if(player8)
                                                            {
                                                               player8.showAttackEffect(18);
                                                            }
                                                         }
                                                      }
                                                      else
                                                      {
                                                         var player7:Living = _game.findLiving(_param1);
                                                         if(player7)
                                                         {
                                                            player7.bomd();
                                                         }
                                                      }
                                                   }
                                                   else
                                                   {
                                                      var skill:int = _param2;
                                                      var livingId:int = _param1;
                                                   }
                                                }
                                                else
                                                {
                                                   var living1:Living = _game.findLiving(_param1);
                                                   if(living1)
                                                   {
                                                      living1.playMovie(ActionType.ACTION_TYPES[_param4]);
                                                   }
                                                }
                                             }
                                             else
                                             {
                                                var living:Living = _game.findLiving(_param1);
                                                if(living)
                                                {
                                                   living.State = _param2;
                                                }
                                             }
                                          }
                                          else
                                          {
                                             var player5:Player = _game.findPlayer(_param1);
                                             if(player5)
                                             {
                                                player5.gemDefense = true;
                                             }
                                          }
                                       }
                                       else
                                       {
                                          var player4:Living = _game.findLiving(_param1);
                                          if(player4)
                                          {
                                             player4.showAttackEffect(2);
                                             player4.updateBlood(_param2,0,_param3);
                                          }
                                       }
                                    }
                                    else
                                    {
                                       var player2:Player = _game.findPlayer(_param1);
                                       if(player2 && player2.isLiving)
                                       {
                                          player2.dander = _param2;
                                       }
                                    }
                                 }
                                 else
                                 {
                                    var player3:Living = _game.findLiving(_param1);
                                    if(player3)
                                    {
                                       player3.isFrozen = false;
                                    }
                                 }
                              }
                              else
                              {
                                 ball.setSpeedXY(new Point(_param1,_param2));
                                 ball.clearWG();
                                 if(_param3 >= 0)
                                 {
                                    var player6:Living = _game.findLiving(_param3);
                                    if(player6)
                                    {
                                       player6.showEffect("asset.game.propanimation.guild");
                                    }
                                 }
                              }
                           }
                           else
                           {
                              var player1:Living = _game.findLiving(_param1);
                              if(player1)
                              {
                                 player1.isFrozen = true;
                                 player1.isHidden = false;
                              }
                           }
                        }
                        else
                        {
                           ball.owner.transmit(new Point(_param1,_param2));
                        }
                     }
                     else
                     {
                        var player:Living = _game.findLiving(_param1);
                        if(player)
                        {
                           if(Math.abs(player.blood - _param4) > 150000 && ball && ball.owner && ball.owner is Player && ball.owner.playerInfo)
                           {
                              SocketManager.Instance.out.sendErrorMsg("客户端发现异常:" + ball.owner.playerInfo.NickName + "打出单发炮弹" + Math.abs(player.blood - _param4) + "的伤害");
                           }
                           player.updateBlood(_param4,_param3,0 - _param2);
                           player.isHidden = false;
                        }
                     }
                  }
                  else
                  {
                     ball.die();
                  }
               }
               else
               {
                  var info:Living = _game.findLiving(_param1);
                  if(info is Player)
                  {
                     (info as Player).playerMoveTo(1,new Point(_param2,_param3),info.direction,_param4 != 0);
                  }
                  else if(info != null)
                  {
                     info.fallTo(new Point(_param2,_param3),Player.FALL_SPEED);
                  }
               }
            }
            else
            {
               ball.x = _param1;
               ball.y = _param2;
               ball.bomb();
            }
         }
         else
         {
            var obj:PhysicalObj = ball.map.getPhysical(_param1);
            if(obj)
            {
               obj.collidedByObject(ball);
            }
         }
      }
   }
}
