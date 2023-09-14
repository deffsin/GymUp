//
//  TabBarView1.swift
//  GymUp
//
//  Created by Denis Sinitsa on 08.09.2023.
//

import SwiftUI

struct TabBarView1: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 40, style: .continuous)
                    .fill(Color.white)
                    .shadow(color: Color.gray.opacity(0.3), radius: 15, x: 0, y: 15)
                    .frame(height: 70)
            }
            .offset(y: 60)
            
            TabsLayoutView(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .padding(.horizontal)
    }
}



fileprivate struct TabsLayoutView: View {
    @Binding var selectedTab: Tab
    @Namespace var namespace
    
    var body: some View {
        HStack {
            Spacer(minLength: 0)
            
            ForEach(Tab.allCases) { tab in
                TabButton(tab: tab, selectedTab: $selectedTab, namespace: namespace)
                    .frame(width: 65, height: 65, alignment: .center)
                
                Spacer(minLength: 0)
            }
        }
        .offset(y: -20)
    }
    
    
    
    private struct TabButton: View {
        let tab: Tab
        @Binding var selectedTab: Tab
        var namespace: Namespace.ID
        
        var body: some View {
            Button {
                withAnimation {
                    selectedTab = tab
                }
            } label: {
                ZStack {
                    if isSelected {
                        Circle()
                            .shadow(radius: 15)
                            .foregroundColor(Color.pink.opacity(0.8))
                            .background {
                                Circle()
                                    .stroke(lineWidth: 11)
                                    .foregroundColor(backgroundColor)
                            }
                            .offset(y: -20)
                            .matchedGeometryEffect(id: "Selected Tab", in: namespace)
                            .animation(.spring(), value: selectedTab)
                    }
                    
                    Image(systemName: tab.icon)
                        .font(.system(size: 23, weight: .semibold, design: .rounded))
                        .foregroundColor(isSelected ? .init(white: 0.9) : .gray)
                        .scaleEffect(isSelected ? 0.9 : 0.8)
                        .offset(y: isSelected ? -20 : 0)
                        .animation(isSelected ? .spring(response: 0.8, dampingFraction: 0.5, blendDuration: 1) : .spring(), value: selectedTab)
                }
                
            }
            .buttonStyle(.plain)
        }
        
        private var isSelected: Bool {
            selectedTab == tab
        }
    }
}


struct TabBarView1_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView1(selectedTab: .constant(.main))
            .padding(.horizontal)
    }
}

