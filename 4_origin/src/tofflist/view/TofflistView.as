package tofflist.view
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.MainToolBar;
   import flash.display.Sprite;
   import tofflist.TofflistController;
   import tofflist.TofflistEvent;
   import tofflist.TofflistModel;
   
   public class TofflistView extends Sprite implements Disposeable
   {
       
      
      private var _contro:TofflistController;
      
      private var _leftView:TofflistLeftView;
      
      private var _rightView:TofflistRightView;
      
      public function TofflistView($contro:TofflistController)
      {
         this._contro = $contro;
         super();
         init();
      }
      
      public function get rightView() : TofflistRightView
      {
         return _rightView;
      }
      
      public function addEvent() : void
      {
         TofflistModel.addEventListener("tofflistdatachange",__tofflistDataChange);
         TofflistModel.addEventListener("crossServerTofflistDataChange",__crossServerTofflistDataChange);
      }
      
      public function dispose() : void
      {
         _contro = null;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _leftView = null;
         _rightView = null;
         MainToolBar.Instance.hide();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function removeEvent() : void
      {
         TofflistModel.removeEventListener("tofflistdatachange",__tofflistDataChange);
         TofflistModel.removeEventListener("crossServerTofflistDataChange",__crossServerTofflistDataChange);
      }
      
      private function __crossServerTofflistDataChange(evt:TofflistEvent) : void
      {
         _rightView.updateTime(evt.data.data.lastUpdateTime);
         var _loc2_:String = evt.data.flag;
         if("individualMountsaccumulate" !== _loc2_)
         {
            if("individualGradeDay" !== _loc2_)
            {
               if("individualgradeWeek" !== _loc2_)
               {
                  if("individualgradeweek" !== _loc2_)
                  {
                     if("individualexploitday" !== _loc2_)
                     {
                        if("individualexploitweek" !== _loc2_)
                        {
                           if("individualexploitaccumulate" !== _loc2_)
                           {
                              if("individualcharmvalueday" !== _loc2_)
                              {
                                 if("individualcharmvalueweek" !== _loc2_)
                                 {
                                    if("individualcharmvalueaccumulate" !== _loc2_)
                                    {
                                       if("consortiagradeaccumulate" !== _loc2_)
                                       {
                                          if("consortiaassetday" !== _loc2_)
                                          {
                                             if("consortiaassetweek" !== _loc2_)
                                             {
                                                if("consortiaassetaccumulate" !== _loc2_)
                                                {
                                                   if("consortiaexploitday" !== _loc2_)
                                                   {
                                                      if("consortiaexploitweek" !== _loc2_)
                                                      {
                                                         if("consortiaexploitaccumulate" !== _loc2_)
                                                         {
                                                            if("consortiaBattleAccumulate" !== _loc2_)
                                                            {
                                                               if("personalBattleAccumulate" !== _loc2_)
                                                               {
                                                                  if("consortiaAchievementPointDay" !== _loc2_)
                                                                  {
                                                                     if("consortiaAchievementPointWeek" !== _loc2_)
                                                                     {
                                                                        if("consortiaAchievementPointAccumulate" !== _loc2_)
                                                                        {
                                                                           if("consortiacharmvalueday" !== _loc2_)
                                                                           {
                                                                              if("consortiacharmvalueweek" !== _loc2_)
                                                                              {
                                                                                 if("consortiacharmvalueAccumulate" !== _loc2_)
                                                                                 {
                                                                                    if("teamIntegral" === _loc2_)
                                                                                    {
                                                                                       this._rightView.orderList(TofflistModel.Instance.crossServerTeamIntegral.list);
                                                                                    }
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    this._rightView.orderList(TofflistModel.Instance.crossServerConsortiaCharmvalue.list);
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 this._rightView.orderList(TofflistModel.Instance.crossServerConsortiaCharmvalueWeek.list);
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              this._rightView.orderList(TofflistModel.Instance.crossServerConsortiaCharmvalueDay.list);
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           this._rightView.orderList(TofflistModel.Instance.crossServerPersonalAchievementPoint.list);
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        this._rightView.orderList(TofflistModel.Instance.crossServerPersonalAchievementPointWeek.list);
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     this._rightView.orderList(TofflistModel.Instance.crossServerPersonalAchievementPointDay.list);
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  this._rightView.orderList(TofflistModel.Instance.crossServerPersonalBattleAccumulate.list);
                                                               }
                                                            }
                                                            else
                                                            {
                                                               this._rightView.orderList(TofflistModel.Instance.crossServerConsortiaBattleAccumulate.list);
                                                            }
                                                         }
                                                         else
                                                         {
                                                            this._rightView.orderList(TofflistModel.Instance.crossServerConsortiaExploitAccumulate.list);
                                                         }
                                                      }
                                                      else
                                                      {
                                                         this._rightView.orderList(TofflistModel.Instance.crossServerConsortiaExploitWeek.list);
                                                      }
                                                   }
                                                   else
                                                   {
                                                      this._rightView.orderList(TofflistModel.Instance.crossServerConsortiaExploitDay.list);
                                                   }
                                                }
                                                else
                                                {
                                                   this._rightView.orderList(TofflistModel.Instance.crossServerConsortiaAssetAccumulate.list);
                                                }
                                             }
                                             else
                                             {
                                                this._rightView.orderList(TofflistModel.Instance.crossServerConsortiaAssetWeek.list);
                                             }
                                          }
                                          else
                                          {
                                             this._rightView.orderList(TofflistModel.Instance.crossServerConsortiaAssetDay.list);
                                          }
                                       }
                                       else
                                       {
                                          this._rightView.orderList(TofflistModel.Instance.crossServerConsortiaGradeAccumulate.list);
                                       }
                                    }
                                    else
                                    {
                                       this._rightView.orderList(TofflistModel.Instance.crossServerPersonalCharmvalue.list);
                                    }
                                 }
                                 else
                                 {
                                    this._rightView.orderList(TofflistModel.Instance.crossServerPersonalCharmvalueWeek.list);
                                 }
                              }
                              else
                              {
                                 this._rightView.orderList(TofflistModel.Instance.crossServerPersonalCharmvalueDay.list);
                              }
                           }
                           else
                           {
                              this._rightView.orderList(TofflistModel.Instance.crossServerIndividualExploitAccumulate.list);
                           }
                        }
                        else
                        {
                           this._rightView.orderList(TofflistModel.Instance.crossServerIndividualExploitWeek.list);
                        }
                     }
                     else
                     {
                        this._rightView.orderList(TofflistModel.Instance.crossServerIndividualExploitDay.list);
                     }
                  }
                  else
                  {
                     this._rightView.orderList(TofflistModel.Instance.crossServerIndividualGradeAccumulate.list);
                  }
               }
               else
               {
                  this._rightView.orderList(TofflistModel.Instance.crossServerIndividualGradeWeek.list);
               }
            }
            else
            {
               this._rightView.orderList(TofflistModel.Instance.crossServerIndividualGradeDay.list);
            }
         }
         else
         {
            this._rightView.orderList(TofflistModel.Instance.crossServerIndividualMountsAccumulate.list);
         }
      }
      
      private function __tofflistDataChange(evt:TofflistEvent) : void
      {
         _rightView.updateTime(evt.data.data.lastUpdateTime);
         var _loc2_:String = evt.data.flag;
         if("individualGradeDay" !== _loc2_)
         {
            if("individualgradeWeek" !== _loc2_)
            {
               if("individualgradeweek" !== _loc2_)
               {
                  if("individualexploitday" !== _loc2_)
                  {
                     if("individualexploitweek" !== _loc2_)
                     {
                        if("individualexploitaccumulate" !== _loc2_)
                        {
                           if("individualcharmvalueday" !== _loc2_)
                           {
                              if("individualcharmvalueweek" !== _loc2_)
                              {
                                 if("individualcharmvalueaccumulate" !== _loc2_)
                                 {
                                    if("individualMatchesDay" !== _loc2_)
                                    {
                                       if("individualMatchesWeek" !== _loc2_)
                                       {
                                          if("individualMatchesTotal" !== _loc2_)
                                          {
                                             if("individualMountsaccumulate" !== _loc2_)
                                             {
                                                if("consortiagradeaccumulate" !== _loc2_)
                                                {
                                                   if("consortiaassetday" !== _loc2_)
                                                   {
                                                      if("consortiaassetweek" !== _loc2_)
                                                      {
                                                         if("consortiaassetaccumulate" !== _loc2_)
                                                         {
                                                            if("consortiaexploitday" !== _loc2_)
                                                            {
                                                               if("consortiaexploitweek" !== _loc2_)
                                                               {
                                                                  if("consortiaexploitaccumulate" !== _loc2_)
                                                                  {
                                                                     if("consortiaBattleAccumulate" !== _loc2_)
                                                                     {
                                                                        if("personalBattleAccumulate" !== _loc2_)
                                                                        {
                                                                           if("individualAchievementPointDay" !== _loc2_)
                                                                           {
                                                                              if("individualAchievementPointWeek" !== _loc2_)
                                                                              {
                                                                                 if("individualAchievementPointAccumulate" !== _loc2_)
                                                                                 {
                                                                                    if("consortiacharmvalueday" !== _loc2_)
                                                                                    {
                                                                                       if("consortiacharmvalueweek" !== _loc2_)
                                                                                       {
                                                                                          if("consortiacharmvalueAccumulate" !== _loc2_)
                                                                                          {
                                                                                             if("teamIntegral" === _loc2_)
                                                                                             {
                                                                                                this._rightView.orderList(TofflistModel.Instance.theServerTeamIntegral.list);
                                                                                             }
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             this._rightView.orderList(TofflistModel.Instance.ConsortiaCharmvalue.list);
                                                                                          }
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          this._rightView.orderList(TofflistModel.Instance.ConsortiaCharmvalueWeek.list);
                                                                                       }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       this._rightView.orderList(TofflistModel.Instance.ConsortiaCharmvalueDay.list);
                                                                                    }
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    this._rightView.orderList(TofflistModel.Instance.PersonalAchievementPoint.list);
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 this._rightView.orderList(TofflistModel.Instance.PersonalAchievementPointWeek.list);
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              this._rightView.orderList(TofflistModel.Instance.PersonalAchievementPointDay.list);
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           this._rightView.orderList(TofflistModel.Instance.personalBattleAccumulate.list);
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        this._rightView.orderList(TofflistModel.Instance.consortiaBattleAccumulate.list);
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     this._rightView.orderList(TofflistModel.Instance.consortiaExploitAccumulate.list);
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  this._rightView.orderList(TofflistModel.Instance.consortiaExploitWeek.list);
                                                               }
                                                            }
                                                            else
                                                            {
                                                               this._rightView.orderList(TofflistModel.Instance.consortiaExploitDay.list);
                                                            }
                                                         }
                                                         else
                                                         {
                                                            this._rightView.orderList(TofflistModel.Instance.consortiaAssetAccumulate.list);
                                                         }
                                                      }
                                                      else
                                                      {
                                                         this._rightView.orderList(TofflistModel.Instance.consortiaAssetWeek.list);
                                                      }
                                                   }
                                                   else
                                                   {
                                                      this._rightView.orderList(TofflistModel.Instance.consortiaAssetDay.list);
                                                   }
                                                }
                                                else
                                                {
                                                   this._rightView.orderList(TofflistModel.Instance.consortiaGradeAccumulate.list);
                                                }
                                             }
                                             else
                                             {
                                                this._rightView.orderList(TofflistModel.Instance.personalMountsAccumulate.list);
                                             }
                                          }
                                          else
                                          {
                                             this._rightView.orderList(TofflistModel.Instance.personalMatchesTotal.list);
                                          }
                                       }
                                       else
                                       {
                                          this._rightView.orderList(TofflistModel.Instance.personalMatchesWeek.list);
                                       }
                                    }
                                    else
                                    {
                                       this._rightView.orderList(TofflistModel.Instance.personalMatchesDay.list);
                                    }
                                 }
                                 else
                                 {
                                    this._rightView.orderList(TofflistModel.Instance.PersonalCharmvalue.list);
                                 }
                              }
                              else
                              {
                                 this._rightView.orderList(TofflistModel.Instance.PersonalCharmvalueWeek.list);
                              }
                           }
                           else
                           {
                              this._rightView.orderList(TofflistModel.Instance.PersonalCharmvalueDay.list);
                           }
                        }
                        else
                        {
                           this._rightView.orderList(TofflistModel.Instance.individualExploitAccumulate.list);
                        }
                     }
                     else
                     {
                        this._rightView.orderList(TofflistModel.Instance.individualExploitWeek.list);
                     }
                  }
                  else
                  {
                     this._rightView.orderList(TofflistModel.Instance.individualExploitDay.list);
                  }
               }
               else
               {
                  this._rightView.orderList(TofflistModel.Instance.individualGradeAccumulate.list);
               }
            }
            else
            {
               this._rightView.orderList(TofflistModel.Instance.individualGradeWeek.list);
            }
         }
         else
         {
            this._rightView.orderList(TofflistModel.Instance.individualGradeDay.list);
         }
      }
      
      public function clearDisplayContent() : void
      {
         _rightView.orderList([]);
         _rightView.updateTime(null);
      }
      
      private function init() : void
      {
         _leftView = new TofflistLeftView();
         addChild(_leftView);
         _rightView = new TofflistRightView(_contro);
         PositionUtils.setPos(_rightView,"tofflist.rightViewPos");
         addChild(_rightView);
         MainToolBar.Instance.show();
      }
   }
}
