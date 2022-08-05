//
//  Classification.swift
//  UI
//
//  Created by JMY on 2022/03/28.
//

struct Classification {
    let title: String
    let pattern: String
}

extension Classification {
    static let koreanConsonants: [Classification] = [
        .init(title: "ㄱ", pattern: "^[가-낗]"),
        .init(title: "ㄴ", pattern: "^[나-닣]"),
        .init(title: "ㄷ", pattern: "^[다-띻]"),
        .init(title: "ㄹ", pattern: "^[라-맇]"),
        .init(title: "ㅁ", pattern: "^[마-밓]"),
        .init(title: "ㅂ", pattern: "^[바-삫]"),
        .init(title: "ㅅ", pattern: "^[사-앃]"),
        .init(title: "ㅇ", pattern: "^[아-잏]"),
        .init(title: "ㅈ", pattern: "^[자-찧]"),
        .init(title: "ㅊ", pattern: "^[차-칳]"),
        .init(title: "ㅋ", pattern: "^[카-킿]"),
        .init(title: "ㅌ", pattern: "^[타-팋]"),
        .init(title: "ㅍ", pattern: "^[파-핗]"),
        .init(title: "ㅎ", pattern: "^[하-힣]"),
    ]

    static let alphabetical: [Classification] = [
        .init(title: "A", pattern: "^(a|A)"),
        .init(title: "B", pattern: "^(b|B)"),
        .init(title: "C", pattern: "^(c|C)"),
        .init(title: "D", pattern: "^(d|D)"),
        .init(title: "E", pattern: "^(e|E)"),
        .init(title: "F", pattern: "^(f|F)"),
        .init(title: "G", pattern: "^(g|G)"),
        .init(title: "H", pattern: "^(h|H)"),
        .init(title: "I", pattern: "^(i|I)"),
        .init(title: "J", pattern: "^(j|J)"),
        .init(title: "K", pattern: "^(k|K)"),
        .init(title: "L", pattern: "^(l|L)"),
        .init(title: "M", pattern: "^(m|M)"),
        .init(title: "N", pattern: "^(n|N)"),
        .init(title: "O", pattern: "^(o|O)"),
        .init(title: "P", pattern: "^(p|P)"),
        .init(title: "Q", pattern: "^(q|Q)"),
        .init(title: "R", pattern: "^(r|R)"),
        .init(title: "S", pattern: "^(s|S)"),
        .init(title: "T", pattern: "^(t|T)"),
        .init(title: "U", pattern: "^(u|U)"),
        .init(title: "V", pattern: "^(v|V)"),
        .init(title: "W", pattern: "^(w|W)"),
        .init(title: "X", pattern: "^(x|X)"),
        .init(title: "Y", pattern: "^(y|Y)"),
        .init(title: "Z", pattern: "^(z|Z)"),
    ]

    static let numerical: [Classification] = [
        .init(title: "0", pattern: "^(0)"),
        .init(title: "1", pattern: "^(1)"),
        .init(title: "2", pattern: "^(2)"),
        .init(title: "3", pattern: "^(3)"),
        .init(title: "4", pattern: "^(4)"),
        .init(title: "5", pattern: "^(5)"),
        .init(title: "6", pattern: "^(6)"),
        .init(title: "7", pattern: "^(7)"),
        .init(title: "8", pattern: "^(8)"),
        .init(title: "9", pattern: "^(9)"),
    ]

    static let lexicographical: [Classification] = [
        .init(title: "0", pattern: "^(0)"),
        .init(title: "1", pattern: "^(1)"),
        .init(title: "2", pattern: "^(2)"),
        .init(title: "3", pattern: "^(3)"),
        .init(title: "4", pattern: "^(4)"),
        .init(title: "5", pattern: "^(5)"),
        .init(title: "6", pattern: "^(6)"),
        .init(title: "7", pattern: "^(7)"),
        .init(title: "8", pattern: "^(8)"),
        .init(title: "9", pattern: "^(9)"),

        .init(title: "A", pattern: "^(a|A)"),
        .init(title: "B", pattern: "^(b|B)"),
        .init(title: "C", pattern: "^(c|C)"),
        .init(title: "D", pattern: "^(d|D)"),
        .init(title: "E", pattern: "^(e|E)"),
        .init(title: "F", pattern: "^(f|F)"),
        .init(title: "G", pattern: "^(g|G)"),
        .init(title: "H", pattern: "^(h|H)"),
        .init(title: "I", pattern: "^(i|I)"),
        .init(title: "J", pattern: "^(j|J)"),
        .init(title: "K", pattern: "^(k|K)"),
        .init(title: "L", pattern: "^(l|L)"),
        .init(title: "M", pattern: "^(m|M)"),
        .init(title: "N", pattern: "^(n|N)"),
        .init(title: "O", pattern: "^(o|O)"),
        .init(title: "P", pattern: "^(p|P)"),
        .init(title: "Q", pattern: "^(q|Q)"),
        .init(title: "R", pattern: "^(r|R)"),
        .init(title: "S", pattern: "^(s|S)"),
        .init(title: "T", pattern: "^(t|T)"),
        .init(title: "U", pattern: "^(u|U)"),
        .init(title: "V", pattern: "^(v|V)"),
        .init(title: "W", pattern: "^(w|W)"),
        .init(title: "X", pattern: "^(x|X)"),
        .init(title: "Y", pattern: "^(y|Y)"),
        .init(title: "Z", pattern: "^(z|Z)"),

        .init(title: "ㄱ", pattern: "^[가-낗]"),
        .init(title: "ㄴ", pattern: "^[나-닣]"),
        .init(title: "ㄷ", pattern: "^[다-띻]"),
        .init(title: "ㄹ", pattern: "^[라-맇]"),
        .init(title: "ㅁ", pattern: "^[마-밓]"),
        .init(title: "ㅂ", pattern: "^[바-삫]"),
        .init(title: "ㅅ", pattern: "^[사-앃]"),
        .init(title: "ㅇ", pattern: "^[아-잏]"),
        .init(title: "ㅈ", pattern: "^[자-찧]"),
        .init(title: "ㅊ", pattern: "^[차-칳]"),
        .init(title: "ㅋ", pattern: "^[카-킿]"),
        .init(title: "ㅌ", pattern: "^[타-팋]"),
        .init(title: "ㅍ", pattern: "^[파-핗]"),
        .init(title: "ㅎ", pattern: "^[하-힣]"),
    ]
}
